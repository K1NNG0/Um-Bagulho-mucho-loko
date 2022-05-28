@echo off
@mode 76,22
@title %~n0
set lch=%cd%
set edition=18.04.2022
set conn=0
set bfunc=0
set lver=7.1
if exist C:\Windows\System32\wget.exe goto connection
set code=404
set motivo="wget nao encontrado"
set resolv="faca o download em https://eternallybored.org/misc/wget/ da versao mais recente e mova o arquivo para C:\Windows\System32"
goto error

:error
cls
echo Ocorreu um Erro
echo codigo %code% %motivo%
echo.
echo %resolv%
if %conn% neq 0 echo Conexao com a internet %conn%
echo.
echo Precione qualquer tecla para sair.
pause >nul
exit

:connection
set conn=online
ping -n 1 8.8.8.8 | find "TTL=" >nul
if errorlevel 1 set conn=offline
if errorlevel 1 set code=408
if errorlevel 1 set motivo="Timeout"
if %conn%==online goto OnLaun
goto error

:OnLaun
cls
if exist batbox.exe set/a bfunc+=1
if exist Button.bat set/a bfunc+=1
if exist GetInput.exe set/a bfunc+=1

if %bfunc% leq 2 goto downbfunc 
if %bfunc%==3 goto ini
if %bfunc% geq 4 goto bfuncerror

:bfuncerror
cls
set code=500
set motivo="bfunc em codigo %bfunc%"
goto error

:downbfunc
cls
wget https://github.com/Psi505/Batch-GUI-Button/archive/refs/heads/main.zip
PowerShell Expand-Archive -Path main.zip -DestinationPath main
copy main\Batch-GUI-Button-main\batbox.exe batbox.exe
copy main\Batch-GUI-Button-main\Button.bat Button.bat
copy main\Batch-GUI-Button-main\GetInput.exe GetInput.exe
rmdir /s /q main
del main.zip
goto ini

:ini
set bfunc=0
Batbox /h 0

:ChFiles
if exist napp set/p AppName=<napp
if not exist napp goto opc
goto ChVers

:opc
title %~n0
cls
Call Button  63 16 " Baixar " 63 19 "  Sair  " # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 goto DloadApp
if %errorlevel%==2 exit
goto opc

:DloadApp
cls
set app=Phone.bat
echo %app% > napp
md djombas
copy batbox.exe djombas\batbox.exe
copy Button.bat djombas\Button.bat
copy GetInput.exe djombas\GetInput.exe
cls
echo Fazendo o Download do arquivo
wget -O %app% https://raw.githubusercontent.com/K1NNG0/Teste/main/Phone.bat
cd djombas
wget -O ini.bat https://raw.githubusercontent.com/K1NNG0/Teste/main/ini.bat
wget -O applist.bat https://raw.githubusercontent.com/K1NNG0/Teste/main/applist.bat
wget -O cnx.bat https://raw.githubusercontent.com/K1NNG0/Teste/main/cnx.bat
wget -O lay.bat https://raw.githubusercontent.com/K1NNG0/Teste/main/lay.bat
cd %lch%
cls
timeout 2 >nul
goto ChFiles

:ChVers
cls
goto opc1

:opc1
title %~n0
cls
Call Button  62 16 " Iniciar " 1 19 "Verificar Arquivos" 63 19 "  Sair  " # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 goto Launch
if %errorlevel%==2 goto DloadApp
if %errorlevel%==3 exit
goto opc1

:Launch
set/p app=<napp
start %app%
exit
