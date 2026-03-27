@echo off
chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

echo.
echo ============================================
echo   Binance Skills Pack - One-Click Installer
echo ============================================
echo.

where npx >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js/npm not found. Please install Node.js first:
    echo         https://nodejs.org
    pause
    exit /b 1
)

set SCRIPT_DIR=%~dp0
set SKILLS_FILE=%SCRIPT_DIR%skills.txt
set TOTAL=0
set SUCCESS=0
set FAILED=0
set FAILED_LIST=

for /f "usebackq eol=# delims=" %%s in ("%SKILLS_FILE%") do (
    set /a TOTAL+=1
)

echo Found !TOTAL! skills to install.
echo.

set /a COUNT=0
for /f "usebackq eol=# delims=" %%s in ("%SKILLS_FILE%") do (
    set /a COUNT+=1
    set SKILL=%%s
    echo [!COUNT!/!TOTAL!] Installing: !SKILL!
    call npx playbooks add skill openclaw/skills --skill !SKILL!
    if !errorlevel! equ 0 (
        echo   [OK] !SKILL! installed successfully.
        set /a SUCCESS+=1
    ) else (
        echo   [FAIL] !SKILL! installation failed.
        set /a FAILED+=1
        if defined FAILED_LIST (
            set FAILED_LIST=!FAILED_LIST!, !SKILL!
        ) else (
            set FAILED_LIST=!SKILL!
        )
    )
    echo.
)

echo ============================================
echo   Installation Complete
echo ============================================
echo   Total:   !TOTAL!
echo   Success: !SUCCESS!
echo   Failed:  !FAILED!
if !FAILED! gtr 0 (
    echo   Failed skills: !FAILED_LIST!
)
echo ============================================
echo.

echo Next steps:
echo   1. Set environment variables:
echo      set BINANCE_API_KEY=your-api-key
echo      set BINANCE_SECRET=your-api-secret
echo   2. Test with testnet first:
echo      set BINANCE_TESTNET=1
echo.

pause
