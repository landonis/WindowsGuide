#Go to github repo and open the script, then hit the raw button to get to this link
$_file = read-host -prompt 'Input file name from github powershell directory'
$RAW = "https://raw.githubusercontent.com/landonis/WindowsGuide/main/Powershell/" + $_file

#Invoke a web request to get the script's text
$script = Invoke-WebRequest $RAW
echo $script
pause
Invoke-Expression $($script.Content)
