Invoke-WebRequest "https://quickpots.fun/ScreenShare/tools/Windows/Other/ClientChecker.exe" -OutFile "ClientChecksTemp"
.\Clientcheckstemp
Read-Host "press any key to continue............."
Remove-Item Clientcheckstemp.exe
