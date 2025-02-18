@echo off

:loop
echo Starting Print.  
title Serial Checker for echo :)
mode con: cols=1000 lines=85
color 0F

echo Disk Number (HDD/SSD):
echo.
wmic diskdrive get serialnumber
wmic VOLUME GET BlockSize,Capacity,DriveLetter,FileSystem,FreeSpace,IndexingEnabled,Label,MaximumFileNameLength

echo.

echo Motherboard (Base Board):
wmic baseboard get serialnumber

echo SMBios:
wmic path win32_computersystemproduct get uuid

echo MEMORY
wmic MEMORYCHIP GET BankLabel,DataWidth,Manufacturer,PartNumber,Capacity,Speed,TypeDetail

echo GPU
wmic PATH Win32_videocontroller GET AdapterRAM,CurrentRefreshRate,Description,DriverVersion,VideoModeDescription
echo.

echo Bios:
wmic csproduct get uuid

echo CPU (Processor):
wmic cpu get processorid, caption, deviceid, name

echo Mac Address:
getmac
echo.
echo System:
wmic OS GET Caption,CodeSet,CSName,InstallDate,Locale,NumberOfProcesses,OSArchitecture,SerialNumber,SystemDirectory,Version
echo.
echo.Startup programs:
wmic STARTUP GET Caption,Command,Location

pause