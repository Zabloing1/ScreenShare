Clear-Host
Write-Host -ForegroundColor Red @"


"@

$tasks = Get-ScheduledTask | ForEach-Object {
    $task = $_
    $actions = $task.Actions | ForEach-Object {        
        [PSCustomObject]@{
            TaskName = $task.TaskName
            TaskPath = $task.TaskPath
            Action = $_.Execute
            Arguments = $_.Arguments
        }
    }
    $actions
}

if ($tasks) {
    $tasks | Out-GridView -Title "List of all Scheduled Tasks" -PassThru
} else {
    Write-Host "No tasks found, perhaps the scheduler service is stopped?"
}