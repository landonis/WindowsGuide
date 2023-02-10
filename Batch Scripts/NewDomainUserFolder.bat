@echo off
setlocal enabledelayedexpansion

set dmain=(Add Domain here)\
set admin_group=%dmain%(Admin Group)
set folder_path=(Path)

set /p userid="userid: "
set dmainUser=%dmain%%userid%


set new_folder=%folder_path%%userid%
call set checks=%%new_folder:%folder_path%=!%%

echo new folder path: %new_folder%

pause
if not "%checks%" == "!" (

	echo assigning %new_folder% to %dmainUser% and %admin_group%
	mkdir "%new_folder%"
	icacls "%new_folder%" /grant "%dmainUser%:(OI)(CI)F" /T
	icacls "%new_folder%" /grant "%admin_group%:(OI)(CI)F" /T
	
	net share "%userid%"="%new_folder%" /Grant:"%userid%",FULL /Grant:"%admin_group%",FULL
	
) 
echo final pause
pause
