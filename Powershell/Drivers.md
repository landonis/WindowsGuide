## List error CIMInstance

     Get-CIMInstance Win32_PNPEntity |Where-Object{$_.Status -eq "Error"} | Select Name

     Get-PNPDevice |where-object{$_.Status -like "Error"} |Select Name
 
## Disable and enable PNP Devices with errors
     
     $PNPDeviceErrors = Get-PNPDevice |where-object{$_.Status -like "Error"} | Select -expandProperty Name
     foreach ($deviceName in $PNPDeviceErrors) {
          $InstanceID = Get-PNPDevice | where-object{$_.Name -eq $deviceName} | Select -ExpandProperty InstanceId
          Disable-PnpDevice -InstanceId $InstanceID -Confirm:$false
          Enable-PnpDevice -InstanceId $InstanceID -Confirm:$false
     }

## pnputil
     pnputil /enum-devices /problem
     pnputil /delete-driver 'hdaudio.inf' /uninstall
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
     

