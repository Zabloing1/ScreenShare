function Menu {
    param (
        [string]$Title = @'
   _______      _________      ___                   _____ _____ 
 |  __ \ \    / /  __ \ \    / (_)                 / ____/ ____|
 | |__) \ \  / /| |__) \ \  / / _ _ __   ___ ___  | (___| (___  
 |  ___/ \ \/ / |  ___/ \ \/ / | | '_ \ / __/ _ \  \___ \\___ \ 
 | |      \  /  | |      \  /  | | | | | (_|  __/  ____) |___) |
 |_|       \/   |_|       \/   |_|_| |_|\___\___| |_____/_____/ 
                                                                
                                                                
'@
    )
	Write-Host @"
   ____        _      _    _____      _          _____ _____ 
  / __ \      (_)    | |  |  __ \    | |        / ____/ ____|
 | |  | |_   _ _  ___| | _| |__) |__ | |_ ___  | (___| (___  
 | |  | | | | | |/ __| |/ /  ___/ _ \| __/ __|  \___ \\___ \ 
 | |__| | |_| | | (__|   <| |  | (_) | |_\__ \  ____) |___) |
  \___\_\\__,_|_|\___|_|\_\_|   \___/ \__|___/ |_____/_____/ 
                                                             
                                                             
                                                                                           
"@																						   
    Write-Host "===================="
    Write-Host "       $SS          "
    Write-Host "===================="
    Write-Host "1. Recycle.bin"
    Write-Host "2. Services Check"
    Write-Host "3. BAM"
    Write-Host "4. USB Log"
    Write-Host "5. Client Checks"
    Write-Host "6. Scheduler Checks"
    Write-Host "7. Log Checks"
    Write-Host "8. Exit"
    Write-Host "===================="
}

function Get-RecycleBinLastModified {
    # Create a Shell.Application instance
    $shell = New-Object -ComObject Shell.Application
    $recycleBin = $shell.Namespace(10)  # 10 is the identifier for the Recycle Bin
    

    $items = @()
    for ($i = 0; $i -lt $recycleBin.Items().Count; $i++) {
        $item = $recycleBin.Items().Item($i)
        $items += [pscustomobject]@{
            Name = $item.Name
            Path = $item.Path
            LastModified = $item.ModifyDate
        }
    }

    if ($items.Count -gt 0) {
        $lastModified = $items | Sort-Object LastModified -Descending | Select-Object -First 1
        
        if ($lastModified) {
            Write-Host "The most recently modified file in the Recycle Bin is:"
            Write-Host "Name: $($lastModified.Name)"
            Write-Host "Path: $($lastModified.Path)"
            Write-Host "Last Modified: $($lastModified.LastModified)"
        } else {
            Write-Host "No files found in the Recycle Bin."
        }
    } else {
        Write-Host "No files found in the Recycle Bin."
    }
}


function Get-USBEvents {
    # Set the date range for the query (last 7 days, for example)
    $startDate = (Get-Date).AddDays(-7)
    $endDate = Get-Date

    # Filter USB-related events from the System event log
    $usbEvents_System = Get-WinEvent -FilterHashtable @{
        LogName = 'System'
        StartTime = $startDate
        EndTime = $endDate
    } | Where-Object {
        $_.Message -like '*USB*' -or $_.Message -like '*Device connected*' -or $_.Message -like '*Device disconnected*'
    } | Select-Object TimeCreated, Id, Message

    # Filter USB-related events from the DriverFrameworks event log
    $usbEvents_Driver = Get-WinEvent -FilterHashtable @{
        LogName = 'Microsoft-Windows-DriverFrameworks-UserMode/Operational'
        StartTime = $startDate
        EndTime = $endDate
    } | Where-Object {
        $_.Message -like '*USB*' -or $_.Message -like '*Device connected*' -or $_.Message -like '*Device disconnected*'
    } | Select-Object TimeCreated, Id, Message

    # Combine and sort events by time
    $events = $usbEvents_System + $usbEvents_Driver | Sort-Object TimeCreated

    # Display the events
    $events | ForEach-Object {
        [PSCustomObject]@{
            Time = $_.TimeCreated
            Event = $_.Id
            Message = $_.Message
        }
    } | Format-Table -AutoSize
}

function Process-Menu {
    param (
        [string]$Choice
    )
    switch($Choice) {
        '1' {
            Get-RecycleBinLastModified
            Start-Sleep 15
            Clear-Host
            Menu
            $selection = Read-Host "Select an option"
            Process-Menu -Choice $selection
        }
        '2' {
            $ErrorActionPreference = "SilentlyContinue"  
             Get-Service SysMain; Get-Service Diagtrack; Get-Service Pcasvc; Get-Service DPS; Get-Service BAM; Get-Service EventLog; Get-Service Schedule; Get-Service SGRMBroker; Get-Service AppInfo
            Start-Sleep 15
            Clear-Host
            Menu
            $selection = Read-Host "Select an option"
            Process-Menu -Choice $selection
        }
        '3' {
            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
            Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/quickpots/ScreenShare/main/BAMViewer.ps1)
        }
        '4' {
            Get-USBEvents
            Start-Sleep 15
            Clear-Host
            Menu
            $selection = Read-Host "Select an option"
            Process-Menu -Choice $selection
        }
        '5' {
            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
            Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/quickpots/ScreenShare/main/ClientChecks.ps1)
        }
       '6' {
            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
            Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/quickpots/ScreenShare/main/AllScheduler.ps1)
        }
       '7' {
            Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
            Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/quickpots/ScreenShare/main/LogsChecker.ps1)
        }
        '8' {
            Clear-Host
            Write-Host -ForegroundColor Green "Exiting... "
            Start-Sleep 3
            exit
        }
        default {
            Write-Host "Invalid option, please try again."
        }
    }
}

Menu
$selection = Read-Host "Select an option"
Process-Menu -Choice $selection