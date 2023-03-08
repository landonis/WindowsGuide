#Connect to exchange online
Install-Module ExchangeOnlineManagement
Connect-ExchangeOnline

#disconnect from exchange online
Disconnect-ExchangeOnline -Confirm:$true

#Get user identity information
Get-User -identity $domain@$domain | Select-Object * 

#Set user organization details
Set-User -identity $user@$domain -Department $Department -Title $Title

#change a users signature
Set-MailboxMessageConfiguration -Identity "John Smith" -SignatureHtml "<html><body>New signature</body></html>"
