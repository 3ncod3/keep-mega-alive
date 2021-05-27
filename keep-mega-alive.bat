@echo off
@rem Keep-MEGA-Alive
@rem https://github.com/3ncod3/keep-mega-alive

setlocal EnableDelayedExpansion
set VERSION=1.2

if "%~1"=="--version" (
  echo Keep-MEGA-Alive v%VERSION%
  goto :eof
)

where /q mega-version
if %errorlevel% neq 0 (
  echo Error: MEGAcmd is not installed. Get it from https://mega.io/cmd
  goto :eof
)

if "%~1" == "" (
  set "LOGINS=mega-logins.csv"
) else (
  set "LOGINS=%1"
)

call mega-logout >NUL
call :log
call :log Starting Keep-MEGA-Alive v%VERSION%

for /F "tokens=1,2" %%i in (%LOGINS%) do (
   call :process %%i %%j > keep-mega-alive.tmp 2>&1
   type keep-mega-alive.tmp >> keep-mega-alive.log
   type keep-mega-alive.tmp
)

goto :cleanup



:log
set "LogMsg=%~1"
echo [%DATE% %TIME%] !LogMsg! >> keep-mega-alive.log

:process
call :log Trying to login as %1
echo %1
call mega-login %1 %2 && (
  call :log Successfully logged in as %1
) || (
  call :log [ERROR] Unable to login as %1
)
call mega-df -h
call mega-logout >NUL
call :log Logged out from %1
echo.
goto :eof

:cleanup
del keep-mega-alive.tmp
call :log Finished running Keep-MEGA-Alive
pause

:eof
