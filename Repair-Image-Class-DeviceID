$hive = Get-ChildItem -Path HKLM:\SYSTEM\CurrentControlSet\Control\Class\ | Where-Object {$_.Name -like "*6bdd1fc6-810f-11d0-bec7-08002*"}
$items = Get-ChildItem -Path Registry::$hive | Where-Object {$_.Property -contains "DeviceID"}

foreach ($key in $items) {
    $name = $key | Select-Object -ExpandProperty Name
    $key_name = Split-Path $name -leaf
    
    $deviceID = Get-ItemProperty -Path Registry::$key | Select -expandProperty DeviceID
    $friendly_name = Get-ItemProperty -Path Registry::$key | Select -expandProperty FriendlyName
    $id_class = Split-Path $deviceID
    $id_leaf = Split-Path $deviceID -leaf

    Write-Output "Checking Hive $($name) for device $($friendly_name), device ID currently set to $($id_leaf)"

    if ($key_name -ne $id_leaf) {
        $new_id = "$($id_class)\$($key_name)"
        Write-Output "Invalid Device ID set for device $($friendly_name), resetting key to $($new_id)"

        Set-ItemProperty -Path Registry::$key -Name DeviceID -Value $new_id

    }
}
