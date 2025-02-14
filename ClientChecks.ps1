Invoke-WebRequest "https://quickpots.fun/ScreenShare/tools/Windows/Other/ClientChecker.exe" -OutFile "ClientChecksTemp.exe"
.\Clientcheckstemp.exe
Read-Host "press any key to continue............."
Remove-Item Clientcheckstemp.exe
