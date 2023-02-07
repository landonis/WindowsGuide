#get bios version from WMIC w/ key
Get-WmiObject Win32Object Win32_BIOS | select -property SMBIOSBIOSVersion
#                                                                               → SMBIOSBIOSVERSION
#                                                                                 -----------------
#                                                                                 {BIOS Version}

#get bios version from computer info w/o key (-expandproperty)

Get-ComputerInfo | select -expandproperty BiosCaption
#                                                                               → {BIOS Version}
