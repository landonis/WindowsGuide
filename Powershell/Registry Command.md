Registry Commands


Get ProfileList Registry keys for users that are not under the windows directory
>  $((Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\' -Recurse) |Where-Object {(Get-ItemProperty -Path Registry::$_).ProfileImagePath -notlike 'C:\Windows\*'})
