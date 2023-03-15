#collection of application management commands

#Programs
Get-Package | Where-Object {($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')} | Select-Object Name

#gives AppxPackages
$AppxNames = Get-AppxPackage | select Name 

#get apps via registry
$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
