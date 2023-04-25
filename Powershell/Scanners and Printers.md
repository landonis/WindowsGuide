# Windows 10 Powershell commands for working with Scanners

## List scanners


> Get-CIMINstance Win32_PNPEntity | Where-Object{$_.PNPClass -eq "Image"} | Select Name

## Printers

See WindowsGuide/Drivers.md for working with print drivers

### list printers

With details

>   Get-CIMInstance Win32_Printer | Select-Object *

>   Get-Printer | Select Name,PrinterStatus,DriverName,PortName,PrintProcessor,Type
