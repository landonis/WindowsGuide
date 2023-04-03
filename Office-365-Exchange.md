# Exchange Online Powershell
Commands will use these placeholder variables:

> $target = Placeholder for a group or account identifier

> $user = Placeholder for the users identifier

> $accessRights = Placeholder for the valid access rights in the command

## Logging in

### Start A Session

> Connect-ExchangeOnline

A login prompt will open, enter Office 365 credentials.

### End Your Session

> Disconnect-ExchangeOnline

## Adjusting Permissions

### Get-MailboxPermission

Gets the current permissions on a Mailbox

> Get-MailboxPermission -Identity $target | Select *


### Add-MailboxPermission 

> Add-MailboxPermission -Identity $target -User $user -AccessRights $accessRights

#### Flags

##### AccessRights
* ChangeOwner
* ChangePermission
* DeleteItem
* ExternalAccount
* FullAccess
* ReadPermission
##### GroupMailbox
* Required to add permissions to 365 group mailbox, don't need any other input

##### Identity
* Name
* Alias
* Distinguished name (DN)
* Canonical DN
* Domain\Username
* Email address
* GUID
* LegacyExchangeDN
* SamAccountName
* User ID or user principal name (UPN)

##### Owner
* Can use Mailbox users, Mail users, Security Groups
* Cant use this with access rights or user parameters

##### User
* No automapping when you use a security group

##### Automapping
* $true
  * Automatically map to the target mailbox to the user's outlook profile when assigned Full Access permission, this is the default behavior
* $false
  * Do not map mailbox to user profile  
* Includes/excludes automatically mapping mailbox to the users Outlook profile via Autodiscover if they have Full Access
* Wont enumerate security groups

### Remove-MailboxPermission

> Remove-MailboxPermission -Identity $target -User $user -AccessRights Editor -InheritanceType All

#### Flags

##### AccessRights
* FullAccess
* SendAs
* ExternalAccount
* DeleteItem
* ReadPermission
* ChangePermission
* ChangeOwner

##### GroupMailbox
* The GroupMailbox switch is required to remove permissions from a Microsoft 365 Group mailbox. You don't need to specify a value with this switch.

### Add-MailboxFolderPermission
   
> $target = target's email + :\Calendar    
> Add-MailboxFolderPermission -Identity $target -User $user -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems

#### Flags

##### AccessRights
* Author: CreateItems, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
* Contributor: CreateItems, FolderVisible
* Editor: CreateItems, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
* NonEditingAuthor: CreateItems, DeleteOwnedItems, FolderVisible, ReadItems
* Owner: CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderContact, FolderOwner, FolderVisible, ReadItems
* PublishingAuthor: CreateItems, CreateSubfolders, DeleteOwnedItems, EditOwnedItems, FolderVisible, ReadItems
* PublishingEditor: CreateItems, CreateSubfolders, DeleteAllItems, DeleteOwnedItems, EditAllItems, EditOwnedItems, FolderVisible, ReadItems
* Reviewer: FolderVisible, ReadItems

##### Access Rights Permisssions
* None: The user has no access to view or interact with the folder or its contents.
* CreateItems: The user can create items within the specified folder.
* CreateSubfolders: The user can create subfolders in the specified folder.
* DeleteAllItems: The user can delete all items in the specified folder.
* DeleteOwnedItems: The user can only delete items that they created from the specified folder.
* EditAllItems: The user can edit all items in the specified folder.
* EditOwnedItems: The user can only edit items that they created in the specified folder.
* FolderContact: The user is the contact for the specified public folder.
* FolderOwner: The user is the owner of the specified folder. The user can view the folder, move the folder and create * subfolders. The user can't read items, edit items, delete items or create items.
* FolderVisible: The user can view the specified folder, but can't read or edit items within the specified public folder.
* ReadItems: The user can read items within the specified folder.

##### SharingPermissionFlags
* Can only be used when Access Rights is assigned Editor
* None: Has no effect. This is the default value.
* Delegate: The user is made a calendar delegate, which includes receiving meeting invites and responses. If there are no other delegates, this value will create the meeting message rule. If there are existing delegates, the user is added to the meeting message rule without changing how delegate messages are sent.
* CanViewPrivateItems: The user can access private items on the calendar. You must use this value with the Delegate value.

### Remove-MailboxFolderPermission

> Remove-MailboxFolderPermission -Identity $target":\Calendar" -User $user
