@echo off

if exist c:\twa.conf goto 3
goto 2

:2
setlocal
set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Please select your Total War Arena folder.',0,0).self.path""

for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"

setlocal enabledelayedexpansion

echo You chose !folder! as your install folder
echo !folder!>c:\twa.conf

:3
set /p twainstall=<c:\twa.conf

echo %twainstall%
if not exist "%twainstall%\data\language.txt" goto 4
if not exist "%twainstall%\data\Backup" mkdir "%twainstall%\data\Backup"
if exist "%twainstall%\data\audio_cn.pack" move "%twainstall%\data\audio_cn.pack" "%twainstall%\data\Backup\"
if exist "%twainstall%\data\local_cn.pack" move "%twainstall%\data\local_cn.pack" "%twainstall%\data\Backup\"
echo EN > "%twainstall%\data\language.txt"
goto 5

:4
Echo Files not found, wrong directory selected, resetting config
del c:\twa.conf
goto 6

:5
echo ####################################
echo #                                  #
echo # Your game is now in English :)   #
echo #                                  #
echo # Settings is saved in c:\twa.conf #
echo #                                  #
echo ####################################

:6
echo Press any key to continue...
endlocal
pause >nul


