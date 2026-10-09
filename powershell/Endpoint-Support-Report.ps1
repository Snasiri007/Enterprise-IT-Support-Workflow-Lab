$ReportPath = "$env:USERPROFILE\Desktop\Endpoint-Support-Report.txt"

# Collect endpoint information
$ComputerInfo = Get-ComputerInfo
$System = Get-CimInstance Win32_ComputerSystem
$Network = Get-NetIPConfiguration | Where-Object { $_.IPv4Address } | Select-Object -First 1
$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$Admins = Get-LocalGroupMember Administrators
$Services = Get-Service WSearch, wuauserv

# Check selected software
$Apps = @(
    @{ Name = "7-Zip"; Id = "7zip.7zip" },
    @{ Name = "Google Chrome"; Id = "Google.Chrome" },
    @{ Name = "Notepad++"; Id = "Notepad++.Notepad++" }
)

$SoftwareReport = foreach ($App in $Apps) {
    $Result = winget list --id $App.Id -e 2>$null | Out-String

    if ($Result -match [regex]::Escape($App.Id)) {
        "$($App.Name): Installed"
    }
    else {
        "$($App.Name): Not installed"
    }
}

# Build report
$Report = @(
    "ENDPOINT SUPPORT REPORT"
    "======================="
    ""
    "Computer Name: $env:COMPUTERNAME"
    "Logged-in User: $($System.UserName)"
    ""
    "WINDOWS"
    "-------"
    "Product: $($ComputerInfo.WindowsProductName)"
    "Version: $($ComputerInfo.WindowsVersion)"
    "Build: $($ComputerInfo.OsBuildNumber)"
    ""
    "HARDWARE"
    "--------"
    "Manufacturer: $($System.Manufacturer)"
    "Model: $($System.Model)"
    "RAM (GB): $([math]::Round($System.TotalPhysicalMemory / 1GB, 2))"
    ""
    "NETWORK"
    "-------"
    "IPv4 Address: $($Network.IPv4Address.IPAddress)"
    "Default Gateway: $($Network.IPv4DefaultGateway.NextHop)"
    "DNS Servers: $($Network.DNSServer.ServerAddresses -join ', ')"
    ""
    "DISK"
    "----"
    "C: Total GB: $([math]::Round($Disk.Size / 1GB, 2))"
    "C: Free GB: $([math]::Round($Disk.FreeSpace / 1GB, 2))"
    ""
    "LOCAL ADMINISTRATORS"
    "--------------------"
)

$Report += $Admins.Name

$Report += @(
    ""
    "SERVICE STATUS"
    "--------------"
)

$Report += $Services | ForEach-Object {
    "$($_.Name): $($_.Status)"
}

$Report += @(
    ""
    "SELECTED SOFTWARE"
    "-----------------"
)

$Report += $SoftwareReport

# Export report
$Report | Set-Content -Path $ReportPath -Encoding UTF8

Write-Host "Report created at: $ReportPath"



