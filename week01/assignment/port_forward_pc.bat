@echo off
setlocal

echo Enter your username:
set /p username=
echo Enter the external IP address:
set /p external_IP=
echo Enter the location of your private key (default: %USERPROFILE%\.ssh\id_rsa):
set /p key_location=

if "%key_location%"=="" set key_location=%USERPROFILE%\.ssh\id_rsa

echo Forwarding for HDFS on port 9870
start cmd.exe /k "ssh -i "%key_location%" -L 9870:localhost:9870 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:9870

echo Forwarding for YARN on port 8088
start cmd.exe /k "ssh -i "%key_location%" -L 8088:localhost:8088 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:8088

echo Forwarding for Spark Master on port 8080
start cmd.exe /k "ssh -i "%key_location%" -L 8080:localhost:8080 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:8080

echo Forwarding for Spark History on port 18080
start cmd.exe /k "ssh -i "%key_location%" -L 18080:localhost:18080 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:18080

echo Forwarding for HBASE on port 16010
start cmd.exe /k "ssh -i "%key_location%" -L 16010:localhost:16010 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:16010

echo Forwarding for Solr on port 8983
start cmd.exe /k "ssh -i "%key_location%" -L 8983:localhost:8983 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start http://localhost:8983

echo Forwarding for NIFI on port 8443
start cmd.exe /k "ssh -i "%key_location%" -L 8443:localhost:8443 %username%@%external_IP% && echo Success || echo Error occurred. Press any key to close... && pause"
timeout /t 3 >nul
start https://localhost:8443/nifi

pause
