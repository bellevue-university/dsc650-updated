@echo off
setlocal enabledelayedexpansion

REM Windows Script for Port Forwarding

echo Enter your username:
set /p username=
echo Enter the external IP address:
set /p external_IP=
echo Enter the location of your private key (default: ~/.ssh/id_rsa):
set /p key_location=

REM Default the private key location if not provided
if "%key_location%"=="" set key_location=~/.ssh/id_rsa

REM Define a subroutine to forward port and open browser
:port_forward
start ssh -i "%key_location%" -L %1:localhost:%1 %username%@%external_IP%
timeout 3 >nul
start http://localhost:%1%2
goto:eof

REM HDFS
call :port_forward 9870
REM YARN
call :port_forward 8088
REM Spark Master
call :port_forward 8080
REM Spark History
call :port_forward 18080
REM HBASE
call :port_forward 16010
REM Solr
call :port_forward 8983
REM NIFI
call :port_forward 8443 /nifi

echo Port forwarding completed.
pause

