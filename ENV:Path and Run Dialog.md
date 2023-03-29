## List current paths
    $env:Path -split ';'
     
## Add a new System Variable path
This will not add the folder/program to the run box

    $new_path = Read-Host -Prompt 'New Path to add to ENV: '
    if (Test-Path $new_path) { 
      $regex_new_path = [regex]::Escape($new_path)
      $cur_path_list = $env:Path -split ';' | Where-Object {$_ -notMatch "^$regex_new_path\\?"}
      $env:Path = ($cur_path_list + $new_path) -join ';'
    } else {
      Throw "'$new_path' is not a valid path."
    }
    
    
## Add a new run dialog

    $run_apps_path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\'
    $new_app = Read-Host -Prompt 'Executable name: '
    $new_key = $run_apps_path + $new_app
    $file_path = Read-Host -Prompt 'Executable path: '
    if (Test-Path $file_path) {  
      New-item -Path $run_apps_path -Name $new_app -Value $file_path -force
      New-ItemProperty -Path $new_key -Name 'Path' -PropertyType ExpandString -Value $file_path
    }
