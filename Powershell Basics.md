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
        Function -ErrorAction Stop
        #ErrorAction Stop will terminate non-terminationg functions so that way you will get the desired catch block
    }
    
    catch [$ExceptionType_FullName] {
        Write-Host "This is a specific error that can send a detailed message for that exception. save the error with the type variable below"
    }
    catch {
    
      $error_out = [PSCustomObject]@{
      message = $Error[0].Exception #message displayed to explain error
      type = $Error[0].Exception.GetType().FullName # This is the error code you can supply after the catch statement to pick up specific errors
      }
  
      Write-Host "An Error Occured in the main script block. $($error_out.message)`n$($error_out.type)"
    }

    finally {

      Remove-PSSession $session
  
    }
