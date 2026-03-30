@echo off
setlocal enabledelayedexpansion

:: ==============================
:: AUTO-ELEVACAO (ADMIN)
:: ==============================
net session >nul 2>&1
if %errorLevel% neq 0 (
echo Solicitando permissao de Administrador...
powershell -Command "Start-Process '%~f0' -Verb RunAs"
exit /b
)

:: ==============================
:: CONFIG
:: ==============================
title Remocao do AnyDesk (AppData)
color 0A

set "PASTA=%APPDATA%\AnyDesk"

echo.
echo ==========================================
echo        REMOCAO DO ANYDESK (APPDATA)
echo ==========================================
echo.

echo Caminho alvo:
echo "%PASTA%"
echo.

:: ==============================
:: VERIFICACAO
:: ==============================
if not exist "%PASTA%" (
echo [INFO] Pasta nao encontrada. Nada a fazer.
goto :fim
)

echo [OK] Pasta encontrada.
echo.

:: ==============================
:: CONFIRMACAO
:: ==============================
choice /m "Deseja excluir permanentemente esta pasta?"

if errorlevel 2 (
echo.
echo Operacao cancelada.
goto :fim
)

:: ==============================
:: ENCERRAR PROCESSO
:: ==============================
echo.
echo Encerrando processos do AnyDesk (se houver)...
taskkill /f /im AnyDesk.exe >nul 2>&1

:: ==============================
:: REMOCAO
:: ==============================
echo Removendo pasta...
rmdir /s /q "%PASTA%"

:: ==============================
:: VERIFICACAO FINAL
:: ==============================
if exist "%PASTA%" (
echo.
echo [ERRO] Nao foi possivel remover a pasta.
) else (
echo.
echo [SUCESSO] Pasta removida com sucesso!
)

:fim
echo.
pause