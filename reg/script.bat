TIMEOUT 10
powershell Set-ExecutionPolicy bypass
powershell -file c:\windows\temp\test.ps1
schtasks /delete /TN "schadmcrack" /F
shutdown /r /t 009
start cmd /c "TIMEOUT 2 && del C:\\schadmcrack /Q /F"
del /Q "c:\windows\temp\test.ps1" 
(goto) 2>nul & del "%~f0"
