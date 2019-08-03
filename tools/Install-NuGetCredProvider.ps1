<#
.SYNOPSIS
    Downloads and installs the Microsoft Artifacts Credential Provider
    from https://github.com/microsoft/artifacts-credprovider
    to assist in authenticating to Azure Artifact feeds in interactive development
    or unattended build agents.
#>
[CmdletBinding()]
Param (
)

$toolsPath = & "$PSScriptRoot\..\azure-pipelines\Get-TempToolsPath.ps1"

if ($IsMacOS -or $IsLinux) {
    $installerScript = "installcredprovider.sh"
    $sourceUrl = "https://raw.githubusercontent.com/microsoft/artifacts-credprovider/master/helpers/installcredprovider.sh"
} else {
    $installerScript = "installcredprovider.ps1"
    $sourceUrl = "https://raw.githubusercontent.com/microsoft/artifacts-credprovider/master/helpers/installcredprovider.ps1"
}

$installerScript = Join-Path $toolsPath $installerScript

if (!(Test-Path $installerScript)) {
    Invoke-WebRequest $sourceUrl -OutFile $installerScript
}

$installerScript = (Resolve-Path $installerScript).Path

if ($IsMacOS -or $IsLinux) {
    chmod u+x $installerScript
}

& $installerScript
