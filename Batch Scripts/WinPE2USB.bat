@echo off
setlocal enabledelayedexpansion
echo WinPE install - Make sure to have the Windows Assessment and Deployment kit + WinPE add-ons installed from https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
call "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat"

if not exists C:\WinPE_amd64 (copype amd64 C:\WinPE_amd64)
set _drive=C:\WinPE_amd64


set /p _boot="USB drive letter: "

start cmd.exe /c "C:\copype amd64 %_drive%" 

MakeWinPEMedia /ufd /f %_drive% %_boot%

