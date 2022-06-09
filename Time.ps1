Clear
 
$Flag = $false
 
While (-not $Flag) {
    $YourTime = Read-Host -Prompt "Enter your end time"
    if ($YourTime -match "^[0-1][\d]|2[0-3]:[0-5][\d]:[0-5][\d]$") {
        $Flag = $true
    }
}

[System.TimeSpan] $EndTime = "00:00:00"
[System.DateTime] $YourTimeBis = $YourTime
[System.DateTime] $CurrentTime = Get-Date
[System.TimeSpan] $Timing = [System.DateTime] $YourTime - $CurrentTime
 
 
While ($Timing -gt $EndTime) {
    Clear
    Write-Host $Timing.Hours":"$Timing.Minutes":"$Timing.Seconds -ForegroundColor Red
    Sleep 1
    $CurrentTime = Get-Date
    $Timing = $YourTimeBis - $CurrentTime
}
 
Write-Host "It's time to go !" -ForegroundColor Green
Sleep 10
Exit 0