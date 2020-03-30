#!/usr/bin/env pwsh

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

$component = Get-Content -Path "component.json" | ConvertFrom-Json
$version = (Get-Content -Path pubspec.yaml | ConvertFrom-yaml ).Item(1).Values

if ($component.version -ne $version) {
    throw "Versions in component.json and pubspec.yaml do not match"
}

# Automatically login to server
# if ($env:NPM_USER -ne $null -and $env:NPM_PASS -ne $null) {
#     npm-cli-login
# }

# Publish to global repository
Write-Output "Pushing package to pub.dev registry"
pub publish
