#collection of application management commands

#Programs
Get-Package | Where-Object {($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')} | Select-Object Name

#gives AppxPackages
$AppxNames = Get-AppxPackage | select Name 

#Get Apps via WMI CIM_Product
Get-WMIObject -class Win32_Product | Where-Object{$_.__SUPERCLASS -eq "CIM_Product"}

#get apps via registry
$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
