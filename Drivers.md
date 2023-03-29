When a device has an error, the first thing to try is to run the disable and enable PNP devices with errors script. If that doesn't seem to work, you can get more information from the device by getting the problem code:

    Get-PNPDevice |where-object{$_.Status -like "Error"} | Select-Object Name,Problem
     
Another option is to use pnputil to enumerate the problem devices. delete and uninstall drivers, then scan-devices and check if you still have errors.

## List and optionally remove lowerfilters from driver classes

    $hive_list = Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Control\Class\ | Where-Object{$_.Property -contains 'LowerFilters'} | Select-Object -ExpandProperty Name

    foreach ($hive in $hive_list) {
        #get a list of registry values under the key with a LowerFilter
        $Property = Get-ItemProperty -Path Registry::$hive 
   
        #Set Variables for property values wanted
        $LowerFilters = $Property | Select-Object -ExpandProperty LowerFilters
        $UpperFilters = $Property | Select-Object -ExpandProperty UpperFilters
        $Class = $Property | Select-Object -ExpandProperty Class

        Write-Host "Lower Filters found on hive:`n$hive"
        Write-Host "Class $Class`nUpper Filters present:`n`t$UpperFilters`nFound Lower Filters:`n`t$LowerFilters`n" 
        $c = Read-Host -Prompt 'Remove Lower Filters? y/n'
        if ($c -eq 'y') {
            #Set LowerFilters to empty string
            Remove-ItemProperty -Path $hive -Name "LowerFilters" -Force
        
        } else {
            Write-Host "Leaving $LowerFilters"
        }
    }

## List error CIMInstance

     Get-CIMInstance Win32_PNPEntity |Where-Object{$_.Status -eq "Error"} | Select Name

     Get-PNPDevice |where-object{$_.Status -like "Error"} |Select Name
 
## Disable and enable PNP Devices with errors
     
    $PNPDeviceErrors = Get-PNPDevice |where-object{$_.Status -like "Error"} | Select-Object Name
    foreach ($deviceName in $PNPDeviceErrors) {
         $InstanceID = Get-PNPDevice | where-object{$_.Name -eq $deviceName} | Select -ExpandProperty InstanceId
         foreach($id in $InstanceId) {
              Disable-PnpDevice -InstanceId $id -Confirm:$false
              Enable-PnpDevice -InstanceId $id -Confirm:$false
         }
    }
## Remove PNP Monitor Devices not Present
     $instanceId = Get-PNPDevice |where-object{$_.Problem -like "CM_PROB_PHANTOM" -and $_.InstanceId -like "*Display*"} |Select -ExpandProperty InstanceID
     foreach($id in $InstanceId) { write-host $id
          pnputil /remove-device $id
     }

## pnputil
     pnputil /enum-devices /problem
     pnputil /delete-driver 'oem.inf' /uninstall
     pnputil /scan-devices
     

## Extract a print driver by name
     
     $driverName = ""
     
     $destinationFolder = "C:\"
     
     $driver = Get-PrinterDriver | Where-Object {$_.Name -eq $driverName}
     
     if ($driver) {
     
          $driverFiles = Get-ChildItem -Path $driver.InfPath -Recurse
     
          $driverFiles | Copy-Item -Destination $destinationFolder
     
     }
     
     else {
     
          Write-Host "Driver not found."
     
     }
     

