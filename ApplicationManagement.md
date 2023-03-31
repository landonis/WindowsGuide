# collection of application management commands

## Remove an msi or program using get-Package/uninstall string

    $search_app = ""
    $ignore = ""
    $app_list = Get-Package | Where-Object {(($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')) -and ($_.Name -like "*$search_app*")}
    foreach ($app in $app_list) {
        $full_name = $app | Select-Object -ExpandProperty Name
        Write-Host "Scan found $($app.ProviderName) app:`n$full_name `nUninstall string:`n$uninstall"
        If ($full_name -ne $ignore) {
            if ($app.ProviderName -eq 'msi') {
            Uninstall-Package $app -Force -Scope AllUsers -Confirm
            } elseif ($app.ProviderName -eq 'Programs') {
                $uninstall = $app.Meta.Attributes["UninstallString"]
                Start-Process -FilePath cmd.exe -ArgumentList '/c', "$uninstall /s" -Wait
            }
        }
    }
    


## Programs
    Get-Package | Where-Object {($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')} | Select-Object Name

## AppxPackages
    $AppxNames = Get-AppxPackage | select Name 

## Get Apps via WMI CIM_Product
    Get-WMIObject -class Win32_Product | Where-Object{$_.__SUPERCLASS -eq "CIM_Product"}

## get apps via registry
    $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
