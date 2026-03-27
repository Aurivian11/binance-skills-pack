$ErrorActionPreference = "Continue"

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$SKILLS_FILE = Join-Path $SCRIPT_DIR "skills.txt"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Binance Skills Pack - One-Click Installer  " -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command npx -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Node.js/npm not found. Install from: https://nodejs.org" -ForegroundColor Red
    exit 1
}

$skills = Get-Content $SKILLS_FILE | Where-Object { $_ -match '\S' -and $_ -notmatch '^\s*#' } | ForEach-Object { $_.Trim() }
$total = $skills.Count

Write-Host "Found $total skills to install."
Write-Host ""

$success = 0
$failed = 0
$failedList = @()

for ($i = 0; $i -lt $total; $i++) {
    $skill = $skills[$i]
    $num = $i + 1

    Write-Host "[$num/$total] Installing: $skill" -ForegroundColor Cyan

    $result = & npx playbooks add skill openclaw/skills --skill $skill 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  [OK] $skill installed successfully." -ForegroundColor Green
        $success++
    } else {
        Write-Host "  [FAIL] $skill installation failed." -ForegroundColor Red
        $failed++
        $failedList += $skill
    }
    Write-Host ""
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Installation Complete" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Total:   $total"
Write-Host "  Success: $success" -ForegroundColor Green
Write-Host "  Failed:  $failed" -ForegroundColor Red
if ($failed -gt 0) {
    Write-Host "  Failed: $($failedList -join ', ')" -ForegroundColor Red
}
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host '  $env:BINANCE_API_KEY="your-api-key"'
Write-Host '  $env:BINANCE_SECRET="your-api-secret"'
Write-Host '  $env:BINANCE_TESTNET="1"    # Test first!'
Write-Host ""

Read-Host "Press Enter to exit"
