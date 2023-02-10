@echo off
setlocal enabledelayedexpansion
echo String cleanup bat

set REM=-;\;/;:
echo Chars to remove: "%REM:;= %"
echo %REM%
set /p REMSpaces=Do you want to remove blank spaces (Y/N)?


set /p _drive="string: "
set out=!_drive!

@for %%i in (%REM%) do (
	@if not "!_drive:%%i=!"=="!_drive!" echo removing character %%i
	set out=!out:%%i=!
)
@if not "!REMSpaces:Y=!"=="!RemSpaces!" (
	@for %%c in (%out%) do (
		set out=!out: =!
	)
)
echo New string: %out%

#basic string replacement

set a=C:\path\
set b=file
set c=%a%%b% 		#	=	c:\path\file
call echo %c:%b%=% 	#	=	c:\path
