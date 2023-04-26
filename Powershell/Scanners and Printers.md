# Windows 10 Powershell commands for working with Scanners

## Printers

See WindowsGuide/Drivers.md for working with print drivers

### list printers

With details

>   Get-CIMInstance Win32_Printer | Select-Object *

>   Get-Printer | Select Name,PrinterStatus,DriverName,PortName,PrintProcessor,Type
