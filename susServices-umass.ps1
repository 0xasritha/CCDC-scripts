<# 
- Services managed by Service Control Manager (SCM)
- Services start at boot, run without user logging in 
#>
<#
Get-WmiObject -Class Win32_Service

$feoBlock = {
    if ($_.BinaryPathName -match '\"(?<Path>.+)\"') {
        $binPath = $Matches["Path"]
    } elseif ($_.BinaryPathName) {
        $binPath = $_.BinaryPathName.split(' ')[0]        
    }
    if (Test-Path -Path $binPath) {
        $file = Get-Item -Path $binPath
        if ($file.VersionInfo.ProductName -ne 'Microsoft® Windows® Operating System') {
            [PSCustomObject]@{
                ServiceName = $_.ServiceName
                DisplayName = $_.DisplayName
                BinaryPath = $file.FullName
                BinaryProductName = $file.VersionInfo.ProductName
            }
        }
    }
}
$svc = Get-Service -WarningAction Ignore -ErrorAction Ignore
$svc | ForEach-Object -Process $feoBlock | FL *
#>

foreach ($service in Get-Service | ForEach-Object { $_.Name }) {
  $path = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\$service | ForEach-Object { $_.ImagePath }

  # Change this as you see fit, but it should catch most externally installed services.
  if ($path -like "*C:\Windows*") {
    continue
  }

  "{0}: {1}" -f $service, $path | Write-Output
}