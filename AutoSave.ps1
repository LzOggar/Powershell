Param(
    [Parameter(Mandatory=$true,Position=1,HelpMessage="Use -s or --src or --source to set the source path.")]
    [ValidateNotNullOrEmpty()]
    [Alias("-s","--src","--source")]
    [System.String] $source,

    [Parameter(Mandatory=$true,Position=1,HelpMessage="Use -d or --dst or --destination to set the destination path.")]
    [ValidateNotNullOrEmpty()]
    [Alias("-d","--dst","--destination")]
    [System.String] $destination,

    [Parameter(Mandatory=$true,Position=1,HelpMessage="Use -e or --ext or --extensions to set the source path.")]
    [ValidatePattern('^(\*\.[a-zA-Z]+,?)+$')]
    [Alias("-e","--ext","--extensions")]
    [System.String] $extensions,

    [Parameter(Mandatory=$false,Position=1,HelpMessage="Use -f or --fst or --first at the first run.")]
    [ValidateNotNullOrEmpty()]
    [Alias("-f","--fst","--first")]
    [System.Boolean] $first
)

$backupfolder = $env:COMPUTERNAME + "_" + $env:USERNAME
$dbname = $env:COMPUTERNAME + "_" + $env:USERNAME + "_HashesDB.xml" 

if($first)
{
    if(Test-Path -Path $source)
    {
        Set-Location -Path $source
        Write-Host -ForegroundColor Red "[-] Collect all files informations in progress"
        if($extensions.Contains(","))
        {
            $n_extensions = $extensions.Split(",")
        } else
        {
            $n_extensions = $extensions
        }
        $files = Get-ChildItem -Recurse -Include $n_extensions -ErrorAction SilentlyContinue
        Write-Host -ForegroundColor Green "[+] Collect all files informations done"
        Write-Host -ForegroundColor Red "[-] Calculate all files hashes in progress"
        $hashes = $files | % {
            Get-FileHash -Algorithm SHA512 -Path $_.FullName -ErrorAction SilentlyContinue
        }
        Write-Host -ForegroundColor Green "[+] Calculate all files hashes done"
        if(Test-Path -Path $destination)
        {
            Set-Location -Path $destination
            Write-Host -ForegroundColor Red "[-] Create backup folder in progress"
            New-Item -Name $backupfolder -ItemType Directory -ErrorAction Stop 1> $null
            Write-Host -ForegroundColor Green "[+] Create backup folder done"
            Write-Host -ForegroundColor Red "[-] Create hashes database in progress"
            $inputs = $hashes | % {
                New-Object -TypeName PSObject -Property @{hash=$_.Hash;path=$_.Path}
            }
            Set-Location -Path $backupfolder
            Export-Clixml -Path $dbname -InputObject $inputs -Encoding UTF8 -ErrorAction Stop
            Write-Host -ForegroundColor Green "[+] Create hashes database done"
            Write-Host -ForegroundColor Red "[-] Copy of files in progress"
            $files | % {
                Copy-Item -Path $_.FullName -Destination . -ErrorAction SilentlyContinue
            }
            Write-Host -ForegroundColor Green "[+] Copy of files done"
        } else
        {
            Write-Host -ForegroundColor Red "[*] $destination path doesn't exist"
        }
    } else 
    {
        Write-Host -ForegroundColor Red "[*] $source path doesn't exist" 
    }
} else
{
    if(Test-Path -Path $destination)
    {
        Set-Location -Path $destination
        if(Test-Path -Path $backupfolder)
        {
            Set-Location -Path $backupfolder
            if(Test-Path -Path $dbname)
            {
                Write-Host -ForegroundColor Red "[-] Recover all hashes from database in progress"
                $old_hashes = Import-Clixml -Path $dbname
                Write-Host -ForegroundColor Red "[+] Recover all hashes from database done"
                if(Test-Path -Path $source)
                {
                    Set-Location -Path $source
                    Write-Host -ForegroundColor Red "[-] Collect all files informations in progress"
                    if($extensions.Contains(","))
                    {
                        $n_extensions = $extensions.Split(",")
                    } else
                    {
                        $n_extensions = $extensions
                    }
                    $files = Get-ChildItem -Recurse -Include $n_extensions -ErrorAction SilentlyContinue
                    Write-Host -ForegroundColor Green "[+] Collect all files informations done"
                    Write-Host -ForegroundColor Red "[-] Calculate all files hashes in progress"
                    $new_hashes = $files | % {
                        Get-FileHash -Algorithm SHA512 -Path $_.FullName -ErrorAction SilentlyContinue
                    }
                    Write-Host -ForegroundColor Green "[+] Calculate all files hashes done"
                    Write-Host -ForegroundColor Red "[-] Compare hashes from database to new hashes in progress"
                    $index_n = 0
                    $upgrade_path = $new_hashes.Path | % {
                        if($old_hashes.Path.Contains($_))
                        {
                            $index_o = $old_hashes.Path.IndexOf($_)
                            if($old_hashes.Hash[$index] -eq $new_hashes.Hash[$index_n])
                            {
                                $_
                            }
                        }
                        $index_n++
                    }
                    Write-Host -ForegroundColor Green "[+] Compare hashes from database to new hashes done"
                    Set-Location -Path $destination
                    Set-Location -Path $backupfolder
                    Write-Host -ForegroundColor Red "[-] Replace old files with new files in progress"
                    $upgrade_path | % {
                        Copy-Item -Path $_ -Destination . -ErrorAction SilentlyContinue -Force
                    }
                    Write-Host -ForegroundColor Green "[+] Replace old files with new files done"
                    Write-Host -ForegroundColor Red "[-] Calculate hash of new files in progress"
                    $files = Get-ChildItem -Recurse -Include $n_extensions -ErrorAction SilentlyContinue
                    $hashes = $files | % {
                        Get-FileHash -Algorithm SHA512 -Path $_.FullName -ErrorAction SilentlyContinue
                    }
                    $inputs = $hashes | % {
                        New-Object -TypeName PSObject -Property @{hash=$_.Hash;path=$_.Path}
                    }
                    Export-Clixml -Path $dbname -InputObject $inputs -Encoding UTF8 -Force -ErrorAction Stop
                } else
                {
                    Write-Host -ForegroundColor Red "[*] $source path doesn't exist"
                }
            } else
            {
                Write-Host -ForegroundColor Red "[*] Hashes database $dbname in $backupfolder doesn't exist"
            }
        } else
        {
            Write-Host -ForegroundColor Red "[*] backup folder $backupfolder in destination doesn't exist"
        }
    } else
    {
        Write-Host -ForegroundColor "[*] $destination path doesn't exist"
    }
}
