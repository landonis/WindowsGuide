## List error CIMInstance

     Get-CIMInstance Win32_PNPEntity |Where-Object{$_.Status -eq "Error"} | Select Name

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
     

