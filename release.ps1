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
dart pub get
Write-Host "Pushing package to pub.dev registry..."
try {
    dart pub publish -f 2>&1
}
catch {
    if ("$_".IndexOf("already exists") -gt 0) {
        Write-Host "Package $($component.name):$($component.version) already exists on pub.dev. Release skipped."
    }
    else {
        Write-Error "Release failed.`n$_"
    }
}
