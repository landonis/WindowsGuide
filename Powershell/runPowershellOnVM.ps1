#Set VMName to the name of the VM you are running the scripts on
$session = New-PSSession -VMName "VMName"

#Copy Folder from Host machine to the Hyper-V Machine
Copy-Item -Path "C:\Path\To\Script\Folder" -Destination "C:\Path\To\Script\Folder" -ToSession $session

#Run the scripts on the session
Invoke-Command -Session $session -FilePath "C:\Path\To\Script\Folder\run.ps1"
#can run a powershell script pointing to bat files since it only will run powershell this way
