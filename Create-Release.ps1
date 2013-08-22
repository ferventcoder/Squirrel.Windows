param(
    [ValidateSet('Rebuild','Build', 'Clean')]
    [string]
    $build = "Rebuild"
    ,
    [ValidateSet('Debug', 'Release')]
    [string]
    $config = "Debug"
)

$rootFolder = split-path -parent $MyInvocation.MyCommand.Definition

$binaries = "$rootFolder\bin\"

if (Test-Path $binaries) { Remove-Item $binaries -Recurse -Force }

. $rootFolder\script\Bump-Version.ps1 -Increment Patch
. $rootFolder\Build-Solution.ps1 -Build $build -Config $config

Remove-Item "$rootFolder\bin\Shimmer.Tests.*.nupkg"
Remove-Item "$rootFolder\bin\Shimmer.WiXUi.*.nupkg"