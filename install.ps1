# Auto-installer for Kuldeep Antigravity Skills (Windows)
param (
    [string]$TargetDir = "$PWD/.agents/skills",
    [switch]$Global = $false
)

$ErrorActionPreference = "Stop"
Write-Host "=====================================================" -ForegroundColor Cyan
Write-Host "   Kuldeep Antigravity Skills Auto-Installer        " -ForegroundColor Green
Write-Host "=====================================================" -ForegroundColor Cyan

if ($Global) {
    $TargetDir = "$HOME/.gemini/config/skills"
}

Write-Host "Target Skills Directory: $TargetDir" -ForegroundColor Yellow
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

$SourceSkills = Join-Path $PSScriptRoot "skills"
$Count = 0

Get-ChildItem -Path $SourceSkills -Directory | ForEach-Object {
    $Dest = Join-Path $TargetDir $_.Name
    Copy-Item -Path $_.FullName -Destination $Dest -Recurse -Force
    $Count++
}

Write-Host "Successfully installed $Count skills into $TargetDir!" -ForegroundColor Green
Write-Host "You can now use all skills directly in Antigravity IDE!" -ForegroundColor Cyan
