Invoke-WebRequest "https://quickpots.fun/ScreenShare/tools/Windows/Other/ClientChecker.exe" -OutFile "ClientChecksTemp"
run Clientcheckstemp.exe
Read-Host "press any key to continue............."
Remove-Item C:\Clientcheckstemp.exe
