# Windows 10 Powershell commands for working with Scanners

## List scanners


> Get-CIMINstance Win32_PNPEntity | Where-Object{$_.PNPClass -eq "Image"} | Select Name
