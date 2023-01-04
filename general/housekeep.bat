:: General Housekeeping
:: https://github.com/HarryVasanth/winTools

@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
echo off
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && goto :eof)

:: User Confirmation
echo This program will perform general housekeeping tasks to optimize your system.
CHOICE /C YN /M "Are you sure? :" 
if exist %errorlevel% goto answerNo
if not exist %errorlevel% GOTO answerYes

:: Perform Housekeeping Tasks
:answerYes

:: Clear Temporary Files
echo Clearing temporary files...
rd /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul 2>&1
rd /s /q "%systemroot%\temp\" >nul 2>&1
mkdir "%systemroot%\temp\" >nul 2>&1
echo Done.

:: Clear Event Logs
echo Clearing event logs...
for /f %x in ('wevtutil el') do wevtutil cl "%x" >nul 2>&1
echo Done.

:: Clear Thumbnail Cache
echo Clearing thumbnail cache...
taskkill /f /im explorer.exe
timeout 3
del /q /f /s "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
timeout 3
start explorer.exe
echo Done.

:: Defragment Drives
echo Defragmenting drives...
defrag C: /v >nul 2>&1
defrag D: /v >nul 2>&1
defrag E: /v >nul 2>&1
echo Done.

:: Clean Up System Files
echo Cleaning up system files...
cleanmgr /sagerun:1 >nul 2>&1
echo Done.

:: Reset Network Settings
echo Resetting network settings...
ipconfig /flushdns >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1
netsh winsock reset >nul 2>&1
echo Done.

:: Check for and Install Updates
echo Checking for and installing updates...
wuauclt /detectnow /updatenow >nul 2>&1
echo Done.

:: Repair Corrupt System Files
echo Repairing corrupt system files...
sfc /scannow >nul 2>&1
echo Done.

:: Optimize Registry
echo Optimizing registry...
regcompact.exe
echo Done.

:: Remove Unnecessary Programs and Features
