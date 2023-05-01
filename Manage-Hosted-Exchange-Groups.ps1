#=============================== Variables ===============================#
$UPN_domain = "" # opt personalization

$_exchange_server = [PSCustomObject]@{
    url = ""                             # *******Fill this******
    auth = 'Kerberos'
}
$_admin = [PSCustomObject]@{
    username = ""#opt personalization 
    auth = 'Kerberos'
    credentials = "$false"
}



#=============================== Functions ===============================#
function Add-Member {
    Param(
    [Parameter()][string] $group_name,
    [Parameter()][string] $target_user
    )
    Write-Host "Attempting to add $target_user to $group_name"
    try {
       Add-DistributionGroupMember -Identity $group_name -Member $target_user -BypassSecurityGroupManagerCheck -ErrorAction Stop
       #BypassSecurityGroupManagerCheck is used to bypass exchanges check to see if the user calling the function is defined under the ManagedBy Property for the specific group
    }
    catch{
        $error_out = [PSCustomObject]@{
        message = $Error[0].Exception
        type = $Error[0].Exception.GetType().FullName
        }
        Write-Host "There was an error when trying to add this user to $($group).`n$($error_out.message)`n$($error_out.type)"
    }
}

function Remove-Member {
    Param(
    [Parameter()][string] $group_name,
    [Parameter()][string] $target_user
    )
    Write-Host "Attempting to remove $target_user from $group_name"
    try {
       Remove-DistributionGroupMember -Identity $group_name -Member $target_user -BypassSecurityGroupManagerCheck -ErrorAction Stop
       #BypassSecurityGroupManagerCheck is used to bypass exchanges check to see if the user calling the function is defined under the ManagedBy Property for the specific group
    }
    catch{
        $error_out = [PSCustomObject]@{
        message = $Error[0].Exception
        type = $Error[0].Exception.GetType().FullName
        }
        Write-Host "There was an error when trying to remove this user from $($group).`n$($error_out.message)`n$($error_out.type)"
    }
}

function List-Members {
    Param(
    [Parameter()][string] $group_name
    )
    try {
        $group_members = Get-DistributionGroupMember -Identity $group | Select-Object -expandProperty PrimarySmtpAddress -ErrorAction Stop
        Write-Host "`nMembers of $($group):`n$($group_members)`n`n"
    }
    catch {
        $error_out = [PSCustomObject]@{
        message = $Error[0].Exception
        type = $Error[0].Exception.GetType().FullName
        }
        Write-Host "There was an error in getting the members. $($error_out.message)`n$($error_out.type)"
    }
    
}


#=============================== Start ===============================#

# try to get admin credentials from executing user and connect to the self-hosted exchange server suppied under the exchange server object above
try {

    #collecting credentials
    if ($_admin.credentials -eq "$false") {
        $_admin.credentials = $host.ui.PromptForCredential("Domain Admin Login", "Please enter your Domain credentials.", "$($_admin.username)$($UPN_domain)", "NetBiosUserName")
    }

    #establishing a connection    

    $session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $_exchange_server.url -Authentication $_exchange_server.auth -Credential $_admin.credentials

    #importing the established PSsession object into the current session

    Import-PSSession $session -DisableNameChecking -ErrorAction Stop

    # try to get the distribution group the executing user wants to manage
    try {  

        $group = Read-Host "`n`nEnter distribution group email:`n"
        $group_object = Get-DistributionGroup -Identity $group -ErrorAction Stop
        
        List-Members -group_name $group -ErrorAction Stop


        #Prompt for function        
        $opt_exec = $true
        $opt_add = [PSCustomObject]@{
            id = '1'
            msg = "1: Add a user to the target distribution group"
        }
        $opt_rem = [PSCustomObject]@{
            id = '0'
            msg = "0: Remove a user from the target distribution group"
        }
        while ($opt_exec -eq $true) {

            $target = Read-Host "Enter a user to configure or hit ctrl+C to cancel"

            $opt = Read-Host "Chose an option:`n$($opt_add.msg)`n$($opt_rem.msg)`n"
            switch ($opt) {
                $opt_add.id {
                    Add-Member -group_name $group -target_user $target -ErrorAction Stop # local function
                    List-Members -group_name $group
                    $opt_exec = $false
                }
                $opt_rem.id {
                    Remove-Member -group_name $group -target_user -ErrorAction Stop # local function
                    List-Members -group_name $group
                    $opt_exec = $false
                }
            }
                 
        }
    }
    catch{
        $error_out = [PSCustomObject]@{
            message = $Error[0].Exception
            type = $Error[0].Exception.GetType().FullName
        }
        Write-Host "There was an error in the main script.`n$($error_out.message)`n$($error_out.type)"
    }
    # if the try block runs, always end it with this
    finally{
        $post_run_group_membership = Get-DistributionGroupMember -Identity $group | Select-Object PrimarySmtpAddress
        Write-Host "Final Members of $($group) after actions:`n$($group_members)"
    }
}
catch {
    $error_out = [PSCustomObject]@{
        message = $Error[0].Exception
        type = $Error[0].Exception.GetType().FullName
    }
    Write-Host "There was an error in the main script.`n$($error_out.message)`n$($error_out.type)"
}

# finally always close out your session
finally{
    Remove-PSSession $session
}
