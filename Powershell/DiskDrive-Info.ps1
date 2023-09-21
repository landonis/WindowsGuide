#use WMI to get storage devices
$DiskDrives = Get-WmiObject -Class MSFT_PhysicalDisk -Namespace root\Microsoft\Windows\Storage


#for each disk found, gather data and output to the console
Foreach($disk in $DiskDrives) {
    $media_type = $disk | Select-Object @{
        name = "MediaType"; 
        expression = {
            switch ($_.MediaType) { 
                0 {"Unspecified"}
                3 {"HDD"}
                4 {"SSD"} 
            } 
        }
     }
    $media_type = $media_type.MediaType
    $bus_type = $disk | Select -Property @{
        name = "BusType";
        expression = {
            switch ($_.BusType) {
                0 {"Unknown"}
                1 {"SCSI"}
                2 {"ATPI"}
                3 {"ATA"}
                7 {"USB"}
                8 {"RAID"}
                9 {"iSCSI"}
                10 {"SAS"}
                11 {"SATA"}
                12 {"SD"}
                13 {"Multimedia Card"}
                15 {"File backed Virtual"}
                16 {"Storage Spaces"}
                17 {"NVMe"}
            }
        }
    }
    $bus_type = $bus_type.BusType
    $size = [int]($disk.Size / 1gb)

    Write-Host "Found disk $($disk.FriendlyName) using bus type $($bus_type). MediaType is $($media_type)`nTotal size is $($size)GB"
}
