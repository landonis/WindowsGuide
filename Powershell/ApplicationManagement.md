#collection of application management commands

##Remove an msi or program using get-Package/uninstall string

    $search_app = ""

    $app_list = Get-Package | Where-Object {(($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')) -and ($_.Name -like "*$search_app*")}

    foreach ($app in $app_list) {
        $full_name = $app | Select-Object Name
        Write-Host "Scan found app:`n$full_name`,Uninstall:`n$uninstall"
        pause
        if ($app.ProviderName -eq 'msi') {
            Uninstall-Package -Name $full_name -Force -Scope AllUsers -Confirm
        } elseif ($app.ProviderName -eq 'Programs') {
            $uninstall = $app.Meta.Attributes["UninstallString"]
            Start-Process -FilePath cmd.exe -ArgumentList '/c', "$uninstall /s" -Wait
        }
    }
    
    
    
$post_scan = Get-Package | Where-Object {(($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')) -and ($_.Name -like "*$search_app*")} | Select -ExpandProperty Name
Write-Host "Post App presence for $search_app :`n $post_scan" 

##Programs
    Get-Package | Where-Object {($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')} | Select-Object Name

##gives AppxPackages
    $AppxNames = Get-AppxPackage | select Name 

##Get Apps via WMI CIM_Product
    Get-WMIObject -class Win32_Product | Where-Object{$_.__SUPERCLASS -eq "CIM_Product"}

##get apps via registry
    $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
