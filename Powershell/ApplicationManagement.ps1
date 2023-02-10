#collection of application management commands

#gives AppxPackages
$AppxNames = Get-AppxPackage | select Name 


#other apps
$PackageNames = Get-Package | select Name

#get apps via registry
$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
