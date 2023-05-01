# Variables

    $variable = "Im a String Variable"
>
    $object = [PSCustomObject]@{
      name = "Im a Object Variable"
    }
    Write-Host "$($object.name) is the object"

### Prompt for input from host

    $input = Read-Host "Enter a string"
    
### Prompt for credentials
    $credentials = $host.ui.PromptForCredential("Credential Popup Title", "Enter your Credentials", "This is where you enter username", "NetBiosUserName")

# best practices

### try/catch/finally

    try {
    
    }

    catch {
    
      $error_out = [PSCustomObject]@{
      message = $Error[0].Exception
      type = $Error[0].Exception.GetType().FullName
      }
  
      Write-Host "An Error Occured in the main script block. $($error_out.message)`n$($error_out.type)"
    }

    finally {

      Remove-PSSession $session
  
    }
