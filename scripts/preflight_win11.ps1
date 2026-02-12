# Glass Dagger Enzyme - Windows 11 Pre-Flight Checker
# Run this in PowerShell to verify system requirements

Write-Host "=== Glass Dagger: Windows 11 Pre-Flight Check ===" -ForegroundColor Cyan
Write-Host ""

$allChecksPassed = $true

# Check 1: Windows 11
Write-Host "Check 1: Windows Version" -ForegroundColor Yellow
$os = Get-CimInstance Win32_OperatingSystem
$osName = $os.Caption
$osBuild = $os.BuildNumber

if ($osName -like "*Windows 11*") {
    Write-Host "  ✅ $osName (Build $osBuild)" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Not Windows 11: $osName" -ForegroundColor Yellow
    Write-Host "     WSL2 will still work, but consider upgrading for best performance" -ForegroundColor Gray
}

# Check 2: Architecture
Write-Host ""
Write-Host "Check 2: System Architecture" -ForegroundColor Yellow
$arch = $env:PROCESSOR_ARCHITECTURE
if ($arch -eq "AMD64") {
    Write-Host "  ✅ x86_64 (AMD64)" -ForegroundColor Green
} elseif ($arch -eq "ARM64") {
    Write-Host "  ⚠️  ARM64 detected" -ForegroundColor Yellow
    Write-Host "     LLVM/Enzyme on ARM64 is experimental" -ForegroundColor Gray
    $allChecksPassed = $false
} else {
    Write-Host "  ❌ Unknown architecture: $arch" -ForegroundColor Red
    $allChecksPassed = $false
}

# Check 3: Available RAM
Write-Host ""
Write-Host "Check 3: Available Memory" -ForegroundColor Yellow
$totalRAM = [math]::Round($os.TotalVisibleMemorySize / 1MB, 2)
$freeRAM = [math]::Round($os.FreePhysicalMemory / 1MB, 2)

Write-Host "  Total RAM: $totalRAM GB" -ForegroundColor Gray
Write-Host "  Free RAM:  $freeRAM GB" -ForegroundColor Gray

if ($totalRAM -ge 16) {
    Write-Host "  ✅ $totalRAM GB is excellent for LLVM builds" -ForegroundColor Green
} elseif ($totalRAM -ge 8) {
    Write-Host "  ⚠️  $totalRAM GB will work but builds may be slow" -ForegroundColor Yellow
    Write-Host "     Consider closing other applications during build" -ForegroundColor Gray
} else {
    Write-Host "  ❌ $totalRAM GB is insufficient (minimum 8GB recommended)" -ForegroundColor Red
    $allChecksPassed = $false
}

# Check 4: Free Disk Space
Write-Host ""
Write-Host "Check 4: Disk Space (C: drive)" -ForegroundColor Yellow
$disk = Get-PSDrive C
$freeSpace = [math]::Round($disk.Free / 1GB, 2)

if ($freeSpace -ge 30) {
    Write-Host "  ✅ $freeSpace GB available" -ForegroundColor Green
} elseif ($freeSpace -ge 20) {
    Write-Host "  ⚠️  $freeSpace GB available (tight but workable)" -ForegroundColor Yellow
} else {
    Write-Host "  ❌ Only $freeSpace GB available (need 20GB minimum)" -ForegroundColor Red
    $allChecksPassed = $false
}

# Check 5: Hyper-V / Virtualization
Write-Host ""
Write-Host "Check 5: Virtualization Support" -ForegroundColor Yellow
$vmSupport = (Get-CimInstance -ClassName Win32_ComputerSystem).HypervisorPresent

if ($vmSupport) {
    Write-Host "  ✅ Hyper-V / WSL2 virtualization enabled" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Virtualization not detected" -ForegroundColor Yellow
    Write-Host "     You may need to enable it in BIOS and/or Windows Features" -ForegroundColor Gray
    Write-Host "     Run: wsl --install (will enable automatically)" -ForegroundColor Gray
}

# Check 6: WSL2 Status
Write-Host ""
Write-Host "Check 6: WSL2 Installation" -ForegroundColor Yellow
try {
    $wslVersion = wsl --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ WSL2 installed" -ForegroundColor Green
        Write-Host "     Version info:" -ForegroundColor Gray
        wsl --list --verbose | Select-Object -First 5 | ForEach-Object { Write-Host "     $_" -ForegroundColor Gray }
    } else {
        Write-Host "  ⚠️  WSL2 not installed" -ForegroundColor Yellow
        Write-Host "     Run: wsl --install (requires admin PowerShell)" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ⚠️  WSL2 not installed" -ForegroundColor Yellow
    Write-Host "     Run: wsl --install (requires admin PowerShell)" -ForegroundColor Gray
}

# Check 7: PowerShell version
Write-Host ""
Write-Host "Check 7: PowerShell Version" -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion
Write-Host "  Version: $psVersion" -ForegroundColor Gray
if ($psVersion.Major -ge 5) {
    Write-Host "  ✅ PowerShell $psVersion is compatible" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  PowerShell version may be too old" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Cyan
if ($allChecksPassed) {
    Write-Host "✅ All critical checks passed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor White
    Write-Host "  1. Install WSL2 (if not already): wsl --install" -ForegroundColor Gray
    Write-Host "  2. Reboot if prompted" -ForegroundColor Gray
    Write-Host "  3. Follow: QUICKSTART_WIN11.md" -ForegroundColor Gray
} else {
    Write-Host "⚠️  Some checks failed. Review above and fix issues." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Common fixes:" -ForegroundColor White
    Write-Host "  - Free up disk space (need 20GB+)" -ForegroundColor Gray
    Write-Host "  - Close memory-intensive apps" -ForegroundColor Gray
    Write-Host "  - Enable virtualization in BIOS" -ForegroundColor Gray
}

Write-Host ""
