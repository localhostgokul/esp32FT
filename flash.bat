@echo off
setlocal EnableDelayedExpansion

:: set firmware details
set Firmware=./ESP32_GENERIC-20250415-v1.25.0.bin
:: set port=COM19
set baud=460800
set chip=esp32
set /a count=0

:main
cls
echo =========================
echo Esp32 Auto flash tool
echo.
echo =========================
echo.

echo Flashed devices: !count!
echo.
set /p port=Enter the COM port (e.g., COM10):
echo Press any key to start flashing...
pause >nul

::start flashing by using python esptool.py
:flashLoop
cls
echo ===========================================
echo Flashing ESP32
echo.
echo Flashed devices: !count!
echo ===========================================
echo.

python -m esptool --port %port% erase-flash
python -m esptool --port %port% --chip %chip% --baud %baud% write-flash 0x1000 %Firmware%

if %errorlevel% neq 0 (
    echo.
    echo Error flashing the device. Please check the connection and try again.
    echo ................................................
    echo Press any key to retry
    echo. 
    pause
    :: goto :EOF
    goto flashLoop
) else (  
    echo Flashing successful!!!!  
    echo ===========================================
    echo.
    :: Increment the count
    set /a count+=1
)

echo Total flashed: %count%
echo Ready for the next device
echo.
echo Press any key to continue or Ctrl+C to exit....
pause >nul
goto flashLoop