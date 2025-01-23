get-service | findstr -i "pcasvc"; get-service | findstr -i "DPS"; get-service | findstr -i "Diagtrack"; get-service | findstr -i "sysmain"; get-service | findstr -i "eventlog"; get-service | findstr -i "sysmain"; get-service | findstr -i "eventlog"
$outputDir = [System.IO.Path]::Combine([Environment]::GetFolderPath('Desktop'), 'sslook')`
New-Item -Path $outputDir -ItemType Directory -Force`
$filteredOutputFile = [System.IO.Path]::Combine($outputDir, '3ADS_Tamper.txt')`
$command = 'fsutil usn readjournal c: csv'`
`
$hiddenWindow = New-Object System.Diagnostics.ProcessStartInfo`
$hiddenWindow.FileName = 'cmd.exe'`
$hiddenWindow.Arguments = "/c $command"`
$hiddenWindow.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden`
$hiddenWindow.CreateNoWindow = $true  `
$hiddenWindow.RedirectStandardOutput = $true  `
$hiddenWindow.RedirectStandardError = $true   `
$hiddenWindow.UseShellExecute = $false       `
`
$process = [System.Diagnostics.Process]::Start($hiddenWindow)`
$journalOutput = ""`
`
while (!$process.HasExited) {`
    $journalOutput += $process.StandardOutput.ReadToEnd() `
    Start-Sleep -Seconds 1  `
}`
`
$errorOutput = $process.StandardError.ReadToEnd()`
`
if ($errorOutput) {`
}`
`
if (-not $journalOutput) {`
    return`
}`
`
$patterns = @("Named data extend", "Named data truncation", "Close")`
`
$filteredOutput = $journalOutput.Split("`n") | Where-Object {`
    $line = $_`
    $matchesAllPatterns = $true`
    foreach ($pattern in $patterns) {`
        if ($line -notmatch $pattern) {`
            $matchesAllPatterns = $false`
            break`
        }`
    }`
    $matchesAllPatterns`
}`
$filteredOutput | Set-Content -Path $filteredOutputFile
get-service | findstr -i "pcasvc"; get-service | findstr -i "DPS"; get-service | findstr -i "sysmain"; get-service | findstr -i "eventlog"
Start-Service -Name 'umRdpService'`

get-service | findstr -i "pcasvc"; get-service | findstr -i "DPS"; get-service | findstr -i "sysmain"; get-service | findstr -i "eventlog"
Get-ChildItem -LiteralPath . -Recurse
Get-ChildItem -Recurse > filelist.txt
(Get-PSReadlineOption).HistorySavePath
cd C:\Users\%username%\OneDrive\Desktop
$file = Read-Host "Provide txts of SearchIndexer or Csrss or Explorer"
if (-not (Test-Path $file -PathType Leaf)) {`
    Write-Host "Unidentified"`
    exit`
}
Get-Content $file | ForEach-Object {`
    $line = $_.Trim()`
    if ($line -match "^([a-zA-Z]:\\.+)\\?$") {`
        $path = $Matches[1]`
        if ($path.EndsWith(":")) {`
            Write-Host "Potential ADS in: $path"`
            $parentDirectory = Split-Path $path -Parent`
            Write-Host ("Results of 'dir /a' for $parentDirectory`:")`
            Push-Location $parentDirectory`
            Get-ChildItem -Force | ForEach-Object {`
                $_.FullName`
            }`
            Pop-Location`
            Write-Host`
        }`
    }`
}
$file = Read-Host "Provide txts of SearchIndexer or Csrss or Explorer"`
if (-not (Test-Path $file -PathType Leaf)) {`
    Write-Host "Unidentified"`
    exit`
}`
Get-Content $file | ForEach-Object {`
    $line = $_.Trim()`
    if ($line -match "^([a-zA-Z]:\\.+)\\?$") {`
        $path = $Matches[1]`
        if ($path.EndsWith(":")) {`
            Write-Host "Potential ADS in: $path"`
            $parentDirectory = Split-Path $path -Parent`
            Write-Host ("Results of 'dir /a' for $parentDirectory`:")`
            Push-Location $parentDirectory`
            Get-ChildItem -Force | ForEach-Object {`
                $_.FullName`
            }`
            Pop-Location`
            Write-Host`
        }`
    }`
}
$file = Read-Host "Provide txts of SearchIndexer or Csrss or Explorer"
if (-not (Test-Path $file -PathType Leaf)) {`
    Write-Host "Unidentified"`
    exit`
}
Get-Content $file | ForEach-Object {`
    $line = $_.Trim()`
    if ($line -match "^([a-zA-Z]:\\.+)\\?$") {`
        $path = $Matches[1]`
        if ($path.EndsWith(":")) {`
            Write-Host "Potential ADS in: $path"`
            $parentDirectory = Split-Path $path -Parent`
            Write-Host ("Results of 'dir /a' for $parentDirectory`:")`
            Push-Location $parentDirectory`
            Get-ChildItem -Force | ForEach-Object {`
                $_.FullName`
            }`
            Pop-Location`
            Write-Host`
        }`
    }`
}
(Get-PSReadLineOption).HistorySavePath
