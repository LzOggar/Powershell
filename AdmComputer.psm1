# Computer System Hardware Classes

Function Get-MotherBoard()
{
    <#
       .SYNOPSYS
            Display current computer motherboard details.
        .DESCRIPTION
            Display current computer motherboard details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_MotherBoardDevice | Select-Object -Property Name,Description,DeviceID,Status,PrimaryBusType,SecondaryBusType,RevisionNumber,@{Name="InstallDate";Expression={$_.ConvertToDateTime($_.InstallDate)}}
}

Function Get-Bios()
{
    <#
       .SYNOPSYS
            Display current computer BIOS details.
        .DESCRIPTION
            Display current computer BIOS details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_Bios | Select-Object -Property Name,Description,Status,Manufacturer,SMBIOSBIOSVersion,BIOSVersion,BuildNumber,SerialNumber,CurrentLanguage,PrimaryBIOS,@{Name="ReleaseDate";Expression={[System.DateTime]::ParseExact($_.ReleaseDate,"yyyyMMdd",$null)}},@{Name="TargetOperatingSystem";Expression={switch($_.TargetOperatingSystem){0{"Unknown"} 1{"Other"} 2{"MacOS"} 3{"Attunix"} 4{"DGUX"} 5{"DECNT"} 6{"Digital Unix"} 7{"OpenVMS"} 8{"HPUX"} 9{"AIX"} 10{"MVS"} 11{"OS400"} 12{"OS/2"} 13{"JavaVM"} 14{"MSDOS"} 15{"Win3X"} 16{"Win95"} 17{"Win98"} 18{"WinNT"} 19{"WinCE"} 20{"Ncr3000"} 21{"NetWare"} 22{"Osf"} 23{"DC/OS"} 24{"Reliant Unix"} 25{"SCO UnixWare"} 26{"SCO OpenServer"} 27{"Sequent"} 28{"Irix"} 29{"Solaris"} 30{"SunOs"} 31{"U6000"} 32{"Aseries"} 33{"TandemNSK"} 34{"TandemNT"} 35{"BS2000"} 36{"Linux"} 37{"Lynx"} 38{"Xenix"} 39{"Vm/Esa"} 40{"Interactive unix"} 41{"BsdUnix"} 42{"FreeBSD"} 43{"NetBSD"} 44{"GNU Hurd"} 45{"OS9"} 46{"MACH Kernel"} 47{"Inferno"} 48{"QNX"} 49{"EPOC"} 50{"IxWorks"} 51{"VxWorks"} 52{"MiNT"} 53{"BeOS"} 54{"HP MPE"} 55{"NextStep"} 56{"PalmPilot"} 57{"Rhapsody"} 58{"Windows 2000"} 59{"Dedicated"} 60{"OS/390"} 61{"VSE"} 62{"TPF"}}}}
}

Function Get-LogicalDisk() {
    <#
        .SYNOPSYS
            Display current computer logical disk details.
        .DESCRIPTION
            Display current computer logical disk details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property @{Name="Disk";Expression={$_.DeviceID}},@{Name="Size";Expression={"{0:N2}" -f ($_.Size/1GB)}},@{Name="UsedSpace";Expression={"{0:N2}" -f (($_.Size-$_.FreeSpace)/1GB)}},@{Name="FreeSpace";Expression={"{0:N2}" -f ($_.FreeSpace/1GB)}}
}

Function Get-MemoryCache()
{
    <#
       .SYNOPSYS
            Display current computer memory cache details.
        .DESCRIPTION
            Display current computer memory cache details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_CacheMemory | Select-Object -Property Name,Description,PNPDeviceID,Status,@{Name="Access";Expression={switch($_.Access){0{"Unknown"} 1{"Readable"} 2{"Writeable"} 3{"Read/Write Supported"} 4{"Write Once"}}}},@{Name="ErrorAccess";Expression={switch($_.ErrorAccess){1{"Other"} 2{"Unknown"} 3{"Read"} 4{"Write"} 5{"Partialk Write"}}}},@{Name="Associativity";Expression={switch($_.Associativity){1{"Other"} 2{"Unknown"} 3{"Direct Mapped"} 4{"2-way Set-Associative"} 5{"4-way Set-Associative"} 6{"Full Associative"} 7{"8-way Set-Associative"} 8{"16-way Set-Associative"}}}},BlockSize,CacheSpeed,@{Name="CacheType";Expression={switch($_.CacheType){1{"Other"} 2{"Unknown"} 3{"Instruction"} 4{"Data"} 5{"Unified"}}}},@{Name="CurrentSRAM";Expression={switch($_.CurrentSRAM){0{"Other"} 1{"Unknown"} 2{"Non-Burst"} 3{"Burst"} 4{"Pipeline Burst"} 5{"Synchronous"} 6{"Asynchronous"}}}},StartingAddress,EndingAddress,NumberOfBlocks,MaxCacheSize 
}

Function Get-Processor() {
    <#
        .SYNOPSYS
            Display current computer processor details.
        .DESCRIPTION
            Display current computer processor details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_Processor | Select-Object -Property Name,Description,Manufacturer,DeviceID,@{Name="Architecture";Expression={switch($_.Architecture){1{"Other"} 2{"Unknown"} 3{"8086"} 4{"80286"} 5{"Intel386™ Processor"} 6{"Intel486™ Processor"} 7{"8087"} 8{"80287"} 9{"80387"} 10{"80487"} 11{"Pentium(R) brand"} 12{"Pentium(R) Pro"} 13{"Pentium(R) II"} 14{"Pentium(R) processor with MMX(TM) technology"} 15{"Celeron(TM)"} 16{"Pentium(R) II Xeon(TM)"} 17{"Pentium(R) III"} 18{"M1 Family"} 19{"M2 Family"} 24{"K5 Family"} 25{"K6 Family"} 26{"K6-2"} 27{"K6-3"} 28{"AMD Athlon(TM) Processor Family"} 29{"AMD(R) Duron(TM) Processor"} 30{"AMD29000 Family"} 31{"K6-2+"} 32{"Power PC Family"} 33{"Power PC 601"} 34{"Power PC 603"} 35{"Power PC 603+"} 36{"Power PC 604"} 37{"Power PC 620"} 38{"Power PC X704"} 39{"Power PC 750"} 48{"Alpha Family"} 49{"Alpha 21064"} 50{"Alpha 21066"} 51{"Alpha 21164"} 52{"Alpha 21164PC"} 53{"Alpha 21164a"} 54{"Alpha 21264"} 55{"Alpha 21364"} 64{"MIPS Family"} 65{"MIPS R4000"} 66{"MIPS R4200"} 67{"MIPS R4400"} 68{"MIPS R4600"} 69{"MIPS R10000"} 80{"SPARC Family"} 81{"SuperSPARC"} 82{"microSPARC II"} 83{"microSPARC IIep"} 84{"UltraSPARC"} 85{"UltraSPARC II"} 86{"UltraSPARC IIi"} 87{"UltraSPARC III"} 88{"UltraSPARC IIIi"} 96{"68040"} 97{"68xxx Family"} 98{"68000"} 99{"68010"} 100{"68020"} 101{"68030"} 112{"Hobbit Family"} 120{"Crusoe(TM) TM5000 Family"} 121{"Crusoe(TM) TM3000 Family"} 122{"Efficeon(TM) TM8000 Family"} 128{"Weitek"} 130{"Itanium(TM) Processor"} 131{"AMD Athlon(TM) 64 Processor Family"} 132{"AMD Opteron(TM) Family"} 144{"PA-RISC Family"} 145{"PA-RISC 8500"} 146{"PA-RISC 8000"} 147{"PA-RISC 7300LC"} 148{"PA-RISC 7200"} 149{"PA-RISC 7100LC"} 150{"PA-RISC 7100"} 160{"V30 Family"} 176{"Pentium(R) III Xeon(TM)"} 177{"Pentium(R) III Processor with Intel(R) SpeedStep(TM) Technology"} 178{"Pentium(R) 4"} 179{"Intel(R) Xeon(TM)"} 180{"AS400 Family"} 181{"Intel(R) Xeon(TM) processor MP"} 182{"AMD AthlonXP(TM) Family"} 183{"AMD AthlonMP(TM) Family"} 184{"Intel(R) Itanium(R) 2"} 185{"Intel Pentium M Processor"} 190{"K7"} 200{"IBM390 Family"} 201{"G4"} 202{"G5"} 203{"G6"} 204{"z/Architecture base"} 250{"i860"} 251{"i960"} 260{"SH-3"} 261{"SH-4"} 280{"ARM"} 281{"StrongARM"} 300{"6x86"} 301{"MediaGX"} 302{"MII"} 320{"WinChip"} 350{"DSP"} 500{"Video Processor"}}}},ProcessorID,ProcessorType,Revision,Role,NumberOfCores,NumberOfEnabledCore,NumberOfLogicalProcessors,CurrentClockSpeed,MaxClockSpeed,LoadPercentage,CurrentVoltage,Status,@{Name="CPUStatus";Expression={switch($_.CPUStatus){0{"Unknown"} 1{"CPU Enabled"} 2{"CPU Disabled by User via BIOS Setup"} 3{"CPU Disabled By BIOS (POST Error)"} 4{"CPU is Idle"} 5{"Reserved"} 6{"Reserved"} 7{"Other"}}}}
}

Function Get-Battery()
{
    <#
       .SYNOPSYS
            Display current computer battery details.
        .DESCRIPTION
            Display current computer battery details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_Battery | Select-Object -Property Name,Description,Status,DeviceID,ConfigManagerUserConfig,DesignCapacity,DesignVoltage,TimeOnBattery,TimeToFullCharge,EstimatedChargeRemaining,EstimatedRunTime,ExpectedBatteryLife,ExpectedLife,FullChargeCapacity,MaxRechargeTime,@{Name="Chemistry";Expression={switch($_.ConfigManagerErrorCode){0{"This device is working properly"} 1{"This device is not configured correcly"} 2{"Windows cannot load the drive for this device"} 3{"The drive for this device might be corrupted,or your system may be running low on memory or other ressources"} 4{"This device is not working properly. One of its drivers or your registry might be corrupted"} 5{"This driver for this device needs a ressource that Windows cannot manage"} 6{"The boot configuration for this device conflicts with other devices"} 7{"Cannot filter"} 8{"The driver loader for the device is missing"} 9{"This device is not working properly because the controlling firmware is reporting the ressources for the device incorrectly"} 10{"This device cannot start"} 11{"This device failed"} 12{"This device cannot find enough free resources that it can use"} 13{"Windows cannot verify this device's resources"} 14{"This device cannot work properly until you restart your computer"} 15{"This device is not working properly because there is probably a re-enumeration problem"} 16{"Windows cannot identify all the resources this device uses"} 17{"This device is asking for an unknown resource type"} 18{"Reinstall the drivers for this device"} 19{"Failure using the VxD loader"} 20{"Your registry might be corrupted"} 21{"System failure: Try changing the driver for this device. If that does not work,see your hardware documentation. Windows is removing this device"} 22{"This device is disabled"} 23{"System failure: Try changing the driver for this device. If that doesn't work,see your hardware documentation"} 24{"This device is not present,is not working properly,or does not have all its drivers installed"} 25{"Windows is still setting up this device"} 26{"Windows is still setting up this device"} 27{"This device does not have valid log configuration"} 28{"The drivers for this device are not installed"} 29{"This device is disabled because the firmware of the device did not give it the required resources"} 30{"This device is using an Interrupt Request (IRQ) resource that another device is using"} 31{"This device is not working properly because Windows cannot load the drivers required for this device"}}}}
}

Function Get-CDROMDrive()
{
    <#
       .SYNOPSYS
            Display current computer cdrom details.
        .DESCRIPTION
            Display current computer cdrom details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_CDROMDrive | Select-Object -Property Name,Description,VolumeName,DeviceID,Manufacturer,Drive,DriveIntegrity,Status,TransferRate,MinBlockSize,MaxBlockSize,Size,MaximumComponentLength,MaxMediaSize,MediaType,MediaLoaded
}

Function Get-Fan()
{
    <#
       .SYNOPSYS
            Display current computer fan details.
        .DESCRIPTION
            Display current computer fan details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_Fan | Select-Object -Property Name,Description,DeviceID,ActiveCooling,Status,@{Name="StatusInfo";Expression={switch($_.StatusInfo){1{"Other"} 2{"Unknown"} 3{"Enabled"} 4{"Disabled"} 5{"Not applicable"}}}},@{Name="Availability";Expression={switch($_.Availability){1{"Other"} 2{"Unknown"} 3{"Running/Full power"} 4{"Warning"} 5{"In test"} 6{"Not applicable"} 7{"Power off"} 8{"Off line"} 9{"Off duty"} 10{"Degraded"} 11{"Not installed"} 12{"Install error"} 13{"Power save - unknown"} 14{"Power save - low power mode"} 15{"Power save - standby"} 16{"Power cycle"} 17{"Power save - warning"} 18{"Paused"} 19{"Not ready"} 20{"Not configured"} 21{"Quiesced"}}}},@{Name="ConfigManagerErrorCode";Expression={switch($_.ConfigManagerErrorCode){0{"This device is working properly"} 1{"This device is not configured correcly"} 2{"Windows cannot load the drive for this device"} 3{"The drive for this device might be corrupted,or your system may be running low on memory or other ressources"} 4{"This device is not working properly. One of its drivers or your registry might be corrupted"} 5{"This driver for this device needs a ressource that Windows cannot manage"} 6{"The boot configuration for this device conflicts with other devices"} 7{"Cannot filter"} 8{"The driver loader for the device is missing"} 9{"This device is not working properly because the controlling firmware is reporting the ressources for the device incorrectly"} 10{"This device cannot start"} 11{"This device failed"} 12{"This device cannot find enough free resources that it can use"} 13{"Windows cannot verify this device's resources"} 14{"This device cannot work properly until you restart your computer"} 15{"This device is not working properly because there is probably a re-enumeration problem"} 16{"Windows cannot identify all the resources this device uses"} 17{"This device is asking for an unknown resource type"} 18{"Reinstall the drivers for this device"} 19{"Failure using the VxD loader"} 20{"Your registry might be corrupted"} 21{"System failure: Try changing the driver for this device. If that does not work,see your hardware documentation. Windows is removing this device"} 22{"This device is disabled"} 23{"System failure: Try changing the driver for this device. If that doesn't work,see your hardware documentation"} 24{"This device is not present,is not working properly,or does not have all its drivers installed"} 25{"Windows is still setting up this device"} 26{"Windows is still setting up this device"} 27{"This device does not have valid log configuration"} 28{"The drivers for this device are not installed"} 29{"This device is disabled because the firmware of the device did not give it the required resources"} 30{"This device is using an Interrupt Request (IRQ) resource that another device is using"} 31{"This device is not working properly because Windows cannot load the drivers required for this device"}}}},ConfigManagerUserConfig,DesiredSpeed,VariableSpeed,@{Name="PowerManagementCapabilities";Expression={switch($_.PowerManagementCapabilities){ 0{"Unknown"} 1{"Not Supported"} 2{"Disabled"} 3{"Enabled"} 4{"Power Saving Modes Entered Automatically"} 5{"Power State Settable"} 6{"Power Cycling Supported"} 7{"Timed Power On Supported"}}}}
}

Function Get-LocalPrinter() {
    <#
        .SYNOPSYS
            Display current computer printer details.
        .DESCRIPTION
            Display current computer printer details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_Printer | Select-Object -Property Location,Local,Network,Name,@{Name="PrinterStatus";Expression={switch($_.PrinterStatus) {1{"Other"} 2{"Unknown"} 3{"Idle"} 4{"Printing"} 5{"Warmup"} 6{"Stopped printing"} 7{"Offline"}}}},ShareName,SystemName
}

Function Get-DesktoMonitor()
{
    <#
        .SYNOPSYS
            Display current computer desktop monitor details.
        .DESCRIPTION
            Display current computer desktop monitor details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_DesktopMonitor | Select-Object -Property Name,Description,DeviceID,Status,@{Name="DisplayType";Expression={switch($_.DisplayType){0{"Unknown"} 1{"Other"} 2{"Multiscan Color"} 3{"Multiscan Monochrome"} 4{"Fixed Frequency Color"} 5{"Fixed Frequency Monochrome"}}}},MonitorType,MonitorManufacturer,ScreenHeight,ScreenWidth
}

# Operating System Classes

Function Get-ComputerSystem() {
    <#
        .SYNOPSYS
            Display current computer system details.
        .DESCRIPTION
            Display current computer system details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_ComputerSystem | Select-Object -Property Name,Description,Manufacturer,Model,@{Name="PCSystemType";Expression={switch($_.PCSystemType){0{"Unspecified"} 1{"Desktop"} 2{"Mobile"} 3{"Workstation"} 4{"Enterprise Server"} 5{"SOHO Server"} 6{"Appliance PC"} 7{"Performance Server"} 8{"Maximum"}}}},SystemType,SystemFamily,@{Name="RAM";Expression={"{0:N2}" -f ($_.TotalPhysicalMemory/1GB)}},Domain,DomainRole,PartOfDomain,DNSHostname,PrimaryOwnerName,PrimaryOwnerContact
}

Function Get-OperatingSystem() {
    <#
        .SYNOPSYS
            Display current computer operating system details.
        .DESCRIPTION
            Display current computer operating system details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property @{Name="Name";Expression={$_.Caption}},Description,Manufacturer,Version,@{Name="OSType";Expression={switch($_.OSType){0{"Unknown"} 1{"Other"} 2{"MacOS"} 3{"Attunix"} 4{"DGUX"} 5{"DECNT"} 6{"Digital Unix"} 7{"OpenVMS"} 8{"HPUX"} 9{"AIX"} 10{"MVS"} 11{"OS400"} 12{"OS/2"} 13{"JavaVM"} 14{"MSDOS"} 15{"Win3X"} 16{"Win95"} 17{"Win98"} 18{"WinNT"} 19{"WinCE"} 20{"Ncr3000"} 21{"NetWare"} 22{"Osf"} 23{"DC/OS"} 24{"Reliant Unix"} 25{"SCO UnixWare"} 26{"SCO OpenServer"} 27{"Sequent"} 28{"Irix"} 29{"Solaris"} 30{"SunOs"} 31{"U6000"} 32{"Aseries"} 33{"TandemNSK"} 34{"TandemNT"} 35{"BS2000"} 36{"Linux"} 37{"Lynx"} 38{"Xenix"} 39{"Vm/Esa"} 40{"Interactive unix"} 41{"BsdUnix"} 42{"FreeBSD"} 43{"NetBSD"} 44{"GNU Hurd"} 45{"OS9"} 46{"MACH Kernel"} 47{"Inferno"} 48{"QNX"} 49{"EPOC"} 50{"IxWorks"} 51{"VxWorks"} 52{"MiNT"} 53{"BeOS"} 54{"HP MPE"} 55{"NextStep"} 56{"PalmPilot"} 57{"Rhapsody"} 58{"Windows 2000"} 59{"Dedicated"} 60{"OS/390"} 61{"VSE"} 62{"TPF"}}}},OSArchitecture,@{Name="OSLangage";Expression={Switch($_.OSLanguage){1{"Arabic"} 4{"Chinese (Simplified)– China"} 9{"English"} 1025{"Arabic-Saudi Arabia"} 1026{"Bulgarian"} 1027{"Catalan"} 1028{"Chinese(Taditional)-Taiwan"} 1029{"Czech"} 1030{"Danish"} 1031{"German-Germany"} 1032{"Greek"} 1033{"English-United States"} 1034{"Spanish-Traditional Sort"} 1035{"Finnish"} 1036{"French-France"} 1037{"Hebrew"} 1038{"Hungarian"} 1039{"Icelandic"} 1040{"Italian-Italy"} 1041{"Japanese"} 1042{"Korean"} 1043{"Dutch-Netherlands"} 1044{"Norwegian-Bokmal"} 1045{"Polish"} 1046{"Portuguese-Brazil"} 1047{"Rhaeto-Romanic"} 1048{"Romanian"} 1049{"Russian"} 1050{"Croatian"} 1051{"Slowak"} 1052{"Albanian"} 1053{"Swedish"} 1054{"Thai"} 1055{"Turkish"} 1056{"Urdu"} 1057{"Indonesian"} 1058{"Ukrainian"} 1059{"Belarusian"} 1060{"Slovenian"} 1061{"Estonian"} 1062{"Latvian"} 1063{"Lithuanian"} 1065{"Persian"} 1066{"Vietnamese"} 1069{"Basque(Basque)"} 1070{"Serbian"} 1071{"Macedonian (Macedonia (FYROM))"} 1072{"Sutu"} 1073{"Tsonga"} 1074{"Tswana"} 1076{"Xhosa"} 1077{"Zulu"} 1078{"Afrikaans"} 1080{"Faeroese"} 1081{"Hindi"} 1082{"Maltese"} 1084{"Scottish Gaelic (United Kingdom)"} 1085{"Yiddish"} 1086{"Malay-Malaysia"} 2049{"Arabic-Iraq"} 2052{"Chinese (Simplified)–PRC"} 2055{"German – Switzerland"} 2057{"English – United Kingdom"} 2058{"Spanish – Mexico"} 2060{"French – Belgium"} 2064{"Italian – Switzerland"} 2067{"Dutch – Belgium"} 2068{"Norwegian – Nynorsk"} 2070{"Portuguese – Portugal"} 2072{"Romanian – Moldova"} 2073{"Russian – Moldova"} 2074{"Serbian – Latin"} 2077{"Swedish – Finland"} 3073{"Arabic – Egypt"} 3076{"Chinese (Traditional) – Hong Kong SAR"} 3079{"German – Austria"} 3081{"English – Australia"} 3082{"Spanish – International Sort"} 3084{"French – Canada"} 3098{"Serbian – Cyrillic"} 4097{"Arabic – Libya"} 4100{"Chinese (Simplified) – Singapore"} 4103{"German – Luxembourg"} 4105{"English – Canada"} 4106{"Spanish – Guatemala"} 4108{"French – Switzerland"} 5121{"Arabic – Algeria"} 5127{"German – Liechtenstein"} 5129{"English – New Zealand"} 5130{"Spanish – Costa Rica"} 5132{"French – Luxembourg"} 6145{"Arabic – Morocco"} 6153{"English – Ireland"} 6154{"Spanish – Panama"} 7169{"Arabic – Tunisia"} 7177{"English – South Africa"} 7178{"Spanish – Dominican Republic"} 8193{"Arabic – Oman"} 8201{"English – Jamaica"} 8202{"Spanish – Venezuela"} 9217{"Arabic – Yemen"} 9226{"Spanish – Colombia"} 10241{"Arabic – Syria"} 10249{"English – Belize"} 10250{"Spanish – Peru"} 11265{"Arabic – Jordan"} 11273{"English – Trinidad"} 11274{"Spanish – Argentina"} 12289{"Arabic – Lebanon"} 12298{"Spanish – Ecuador"} 13313{"Arabic – Kuwait"} 13322{"Spanish – Chile"} 14337{"Arabic – U.A.E."} 14346{"Spanish – Uruguay"} 15361{"Arabic – Bahrain"} 15370{"Spanish – Paraguay"} 16385{"Arabic – Qatar"} 16394{"Spanish – Bolivia"} 17418{"Spanish – El Salvador"} 18442{"Spanish – Honduras"} 19466{"Spanish–Nicaragua"} 20490{"Spanish–Puerto Rico"}}}},@{Name="OSProductSuite";Expression={switch($_.OSProductSuite){1{"Microsoft Small Business Server"} 2{"Windows Server 2008 Enterprise"} 4{"Windows BackOffice components"} 8{"Communication Server"} 16{"Terminal Services"} 32{"Microsoft Small Business Server"} 64{"Windows Embedded"} 128{"A Datacenter edition"} 256{"Terminal Services"} 512{"Windows Home Edition"} 1024{"Web Server Edition"} 8192{"Storage Server Edition"} 16384{"Compute Cluster Edition"}}}},BuildDevice,BuildNumber,BuildType,EncryptionLevel,WindowsDirectory,@{Name="InstallDate";Expression={[System.DateTime]::ParseExact($_.InstallDate,"yyyyMMdd",$null)}}
}

Function Get-OperatingSystemLicenseKey() {
    <#
        .SYNOPSYS
            Display current computer operating system license key details.
        .DESCRIPTION
            Display current computer operating system license key details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class SoftwareLicensingService | Select-Object -Property @{Name="ProductKey";Expression={$_.OA3xOriginalProductKey}}
}

Function Get-MSISoftware() {
    <#
        .SYNOPSYS
            Display current computer MSI Software details.
        .DESCRIPTION
            Display current computer MSI Software details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_Product | Select-Object -Property Name,Version,@{Name="Publisher";Expression={$_.Vendor}} | Where-Object {! $_.Name -eq ""} | Sort-Object -Property Name -Unique
}

Function Get-Software() {
    <#
        .SYNOPSYS
            Display current computer all softwares details.
        .DESCRIPTION
            Display current computer all softwares details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    $keys=@("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*")
    $keys | % {
        Get-ItemProperty -Path $_ | Select-Object -Property @{Name="Name";Expression={$_.DisplayName}},@{Name="Version";Expression={$_.DisplayVersion}},@{Name="InstallDate";Expression={[System.DateTime]::ParseExact($_.InstallDate,"yyyyMMdd",$null)}},Publisher | Where-Object {! $_.Name -eq "" -and $_.Name -notmatch "(KB[0-9]+)"} | Sort-Object -Property Name -Unique
    }
}

Function Get-WindowsUpdateHistory() {
    <#
        .SYNOPSYS
            Display current computer windows update history details.
        .DESCRIPTION
            Display current computer windows update history details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    $Session=New-Object -ComObject Microsoft.Update.Session
    $Searcher=$Session.CreateUpdateSearcher()
    $HistoryCount=$Searcher.GetTotalHistoryCount()
    $Searcher.QueryHistory(1,$historyCount) | Select-object -Property  Date,Title,Description,@{Name="Operation";Expression={switch($_.operation){1 {"Installation"}; 2 {"Uninstallation"}; 3 {"Other"}}}},@{Name="Status";Expression={switch($_.resultcode){1 {"In Progress"}; 2 {"Succeded"}; 3 {"Succeded With Errors"}; 4 {"Failed"}; 5 {"Aborted"}}}} | Sort-Object -Property Date
}

Function Get-LocalUserAccount() {
    <#
        .SYNOPSYS
            Display current computer user account details.
        .DESCRIPTION
            Display current computer user account details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_UserAccount | Select-Object -Property Name,SID,@{Name="Type";Expression={$_.AccountType}},Domain
}

Function Get-LocalUserProfile() {
    <#
        .SYNOPSYS
            Display current computer user profile details.
        .DESCRIPTION
            Display current computer user profile details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_UserProfile | Select-Object -Property LocalPath,SID,@{Name="LastUseTime";Expression={$_.ConvertToDateTime($_.LastUseTime)}}
}

Function Get-LocalGroup()
{
    <#
       .SYNOPSYS
            Display current computer group details.
        .DESCRIPTION
            Display current computer group details.
        .PARAMETER
            None
        .EXAMPLE 
    #>

    Get-WmiObject -Class Win32_Group | Select-Object -Property Name,Description,LocalAccount,SID,Status
}

Function Get-StartupCommand() {
    <#
        .SYNOPSYS
            Display current computer startup command details.
        .DESCRIPTION
            Display current computer startup command details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_StartupCommand | Select-Object -Property @{Name="Name";Expression={$_.Caption}},Command,Location,User | Sort-Object -Property Name
}

Function Get-ShortcutFiles()
{
    <#
        .SYNOPSYS
            Display current computer shorcut files details.
        .DESCRIPTION
            Display current computer shortcut files details.
        .PARAMETER
            None
        .EXAMPLE
    #>

    Get-WmiObject -Class Win32_ShortCutFile | Select-Object -Property Name,Description,Status,Manufacturer,Drive,Path,Version,FileName,@{Name="FileSize";Expression={"{0:N2} (KB)" -f ($_.FileSize/1KB)}},FileType,Extension,Target,@{Name="InstallDate";Expression={$_.ConvertToDateTime($_.InstallDate)}},AccessMask,Archive,Compressed,CompressionMethod,Encrypted,EncryptionMethod,Hidden,Writeable,@{Name="LastAccessed";Expression={$_.ConvertToDateTime($_.LastAccessed)}},@{Name="LastModified";Expression={$_.ConvertToDateTime($_.LastModified)}}
}