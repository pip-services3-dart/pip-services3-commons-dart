#!/usr/bin/env pwsh

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

$component = Get-Content -Path "component.json" | ConvertFrom-Json
$pubSpecVersion = $(Get-Content -Path pubspec.yaml) -match "version:" -replace "version: " -replace "'" -replace "`""

if ($component.version -ne $pubSpecVersion) {
    throw "Versions in component.json and pubspec.yaml do not match"
}

Write-Host "Formating code before publish..."
dart format lib test

# Publish to global repository
pub get
Write-Host "Pushing package to pub.dev registry..."
dart pub publish -f 2>&1

if ($LastExitCode -ne 0) {
    # Verify if publish failed because of allready existed version
    if ($Error[0].ToString().IndexOf("already exists") -gt 0) {
        Write-Host "Package $($component.name):$($component.version) allready exists on pub.dev"
    } else {
        Write-Error "Release failed. Watch logs above."
    }
}
