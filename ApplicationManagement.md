# collection of application management commands

## Remove an msi or program 
#### get-Package/uninstall string

    $search_app = ""
    $ignore = ""
    $app_list = Get-Package | Where-Object {(($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')) -and ($_.Name -like "*$search_app*")}
    foreach ($app in $app_list) {
        $full_name = $app | Select-Object -ExpandProperty Name
        $uninstall_string = $app.Meta.Attributes["UninstallString"]
        $product_code = $app.meta.Attributes["ProductCode"]
        Write-Output "Scan found $($app.ProviderName) app:`n$full_name `nUninstall string:`n$uninstall_string"
        If ($full_name -ne $ignore) {
            if ($app.ProviderName -eq 'msi') {
                Uninstall-Package $app -Force -Scope AllUsers -Confirm
                
            } elseif ($app.ProviderName -eq 'Programs') {
                $uninstall_return = (Start-Process -FilePath cmd.exe -ArgumentList '/c', "$uninstall /s" -Wait -Passthrough).ExitCode
                Write-Output "uninstall process for $full_name returned $uninstall_return"
            }
        }
    }
    
#### msiexec/productCode

    $keyword = ""
    $matched_apps = get-package | where-object{($_.ProviderName -eq 'msi') -and ($_.name -like "*$($keyword)*"}
    Write-Output "Found apps: $($matched_apps)"
    foreach ($app in $matched_apps){
        Write-Output "Running msiexec on $($app.Name)
        $product_code = $app.meta.Attributes["ProductCode"]
        msiexec /x $product_code /norestart /qn /passive
    }


## Programs
    Get-Package | Where-Object {($_.ProviderName -eq 'Programs') -or ($_.ProviderName -eq 'msi')} | Select-Object Name

## AppxPackages
    $AppxNames = Get-AppxPackage | select Name 

## Get Apps via WMI CIM_Product
    Get-WMIObject -class Win32_Product | Where-Object{$_.__SUPERCLASS -eq "CIM_Product"}

## get apps via registry
    $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
