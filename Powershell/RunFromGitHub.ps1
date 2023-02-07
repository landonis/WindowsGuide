#Go to github repo and open the script, then hit the raw button to get to this link
$RAW = "https://raw.githubusercontent.com/landonis/WindowsGuide/main/Powershell/RunFromGitHub.ps1"

#Invoke a web request to get the script's text
$script = Invoke-WebRequest $RAW
echo $script
pause
Invoke-Expression $($script.Content)
