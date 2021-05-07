:: Clear All Temporary Files
:: https://github.com/HarryVasanth/winTools

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && exit /b 1)

:: User Confirmation
echo This program will clear all Event Logs,Temporary Files and Thumbnail Caches.
CHOICE /C YN /M "Are you sure? :" 
IF ERRORLEVEL 2 goto answerNo
IF ERRORLEVEL 1 GOTO answerYes


:: Clear Files from %temp% and %WINDIR%/temp 
:answerYes
rd /s /q %temp% >nul 2>&1
mkdir %temp% >nul 2>&1
rd /s /q %WINDIR%\temp\ >nul 2>&1
mkdir %WINDIR%\temp\ >nul 2>&1

:: Clear Eventlogs
for /f %x in ('wevtutil el') do wevtutil cl "%x" >nul 2>&1

:: Clear Thumbnail Cache
taskkill /f /im explorer.exe
timeout 3
DEL /F /S /Q /A %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db
timeout 3
start explorer.exe

:: Done
echo "All done!"
pause
exit /b 0

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
exit /b 0
