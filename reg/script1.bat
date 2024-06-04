net user crack /delete
schtasks /delete /TN "schadmcrack" /F
shutdown /r /t 009
start cmd /c "TIMEOUT 2 && del C:\\schadmcrack /Q /F"
(goto) 2>nul & del "%~f0"