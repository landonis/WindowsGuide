In powershell, you can use $error[0] to pull the information from the last encountered error.

To pull the type of the exception for use in a try/catch statement, use:

$error[0].Exception.getType().fullname

Add the exception like this:

try {
$string = a 
} 
catch [System.Management.Automation.CommandNotFoundException] {
Write-Host "Did you forget the quotes?"
}


If it still isn't working, the ErrorAction may not be set to Stop. Try running like this:

try {
    $Disk = Get-BitLockerVolume -MountPoint $mount_point -ErrorAction Stop
} 

catch [System.Runtime.InteropServices.COMException] {
    Write-Host "`nNo Bitlocker Volume found at $($mount_point)`n"
} 
