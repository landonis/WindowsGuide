$session = New-PSSession -VMName "VMName"
Copy-Item -Path "C:\Path\To\Script.ps1" -Destination "C:\Path\To\Script.ps1" -ToSession $session
Invoke-Command -Session $session -FilePath "C:\Path\To\Script.ps1"
