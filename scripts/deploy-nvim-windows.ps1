<#
.SYNOPSIS
    Deploy nvim config + plugins to Windows from portable zip
.DESCRIPTION
    Extracts nvim-windows-portable.zip to correct Windows nvim paths.
    Assumes: No existing nvim, no admin, zip in Downloads folder.
#>

param(
    [string]$ZipPath = "$env:USERPROFILE\Downloads\nvim-windows-portable.zip"
)

# Target paths (Windows nvim defaults)
$configTarget = "$env:LOCALAPPDATA\nvim"
$pluginsTarget = "$env:LOCALAPPDATA\nvim-data\lazy"

Write-Host "=== nvim Windows Deployment ===" -ForegroundColor Cyan
Write-Host "Zip: $ZipPath"
Write-Host "Config -> $configTarget"
Write-Host "Plugins -> $pluginsTarget"

if (-not (Test-Path $ZipPath)) {
    Write-Error "Zip not found at $ZipPath"
    exit 1
}

# Create temp extraction directory
$tempDir = "$env:TEMP\nvim-deploy-$(Get-Random)"
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

try {
    Write-Host "`nExtracting..." -ForegroundColor Yellow
    Expand-Archive -Path $ZipPath -DestinationPath $tempDir -Force
    
    Write-Host "Creating target directories..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Force -Path $configTarget | Out-Null
    New-Item -ItemType Directory -Force -Path $pluginsTarget | Out-Null
    
    Write-Host "Deploying config..." -ForegroundColor Yellow
    Copy-Item -Path "$tempDir\nvim-portable\config\*" -Destination $configTarget -Recurse -Force
    
    Write-Host "Deploying plugins..." -ForegroundColor Yellow
    Copy-Item -Path "$tempDir\nvim-portable\plugins\*" -Destination $pluginsTarget -Recurse -Force
    
    # Verify
    $lazyExists = Test-Path "$pluginsTarget\lazy.nvim"
    $initExists = Test-Path "$configTarget\init.lua"
    $pluginCount = (Get-ChildItem $pluginsTarget -Directory).Count
    
    Write-Host "`n=== Verification ===" -ForegroundColor Cyan
    Write-Host "init.lua: $([string]::Format('{0}', $initExists))"
    Write-Host "lazy.nvim: $([string]::Format('{0}', $lazyExists))"
    Write-Host "Plugin folders: $pluginCount"
    
    if ($lazyExists -and $initExists -and $pluginCount -ge 28) {
        Write-Host "`n✅ Deployment successful! Run 'nvim' to start." -ForegroundColor Green
    } else {
        Write-Warning "Deployment may be incomplete. Check paths above."
    }
}
finally {
    Write-Host "`nCleaning up..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}