Properties { 
	$solutionFile = $p1
	$configMode = $p2
	$buildCounter = $p3
    $suffix = $p4

    $solutionFolder = Split-Path $solutionFile
}

$ErrorActionPreference = "Stop"
$DebugPreference = "Continue"

$nunitLocation = "$PSScriptRoot\NUnit.Runners.2.6.3\tools\nunit-console.exe"
$baseModulePath = "$PSScriptRoot\modules"

Import-Module "$baseModulePath\teamcity.psm1"
Import-Module "$baseModulePath\Invoke-MsBuild.psm1"
Import-Module "$baseModulePath\Set-VersionNumber.psm1"

Task default -depends Invoke-Commit

TaskSetup {
    TeamCity-ReportBuildProgress "Running task $($psake.context.Peek().currentTaskName)"
}

Task Invoke-Commit -depends Invoke-Compile, Invoke-UnitTests {
    # Need to roll back changes	
}

Task Invoke-Compile -depends Invoke-HardcoreClean, Set-VersionNumber {

	Write-Host "Building ""$solutionFile"" in ""$configMode"" mode."
	Invoke-MsBuild -Path $solutionFile -MsBuildParameters "/t:ReBuild /t:Clean /p:Configuration=$configMode /p:PlatformTarget=""AnyCPU"" /verbosity:d"
}

Task Invoke-HardcoreClean {
	Get-ChildItem -Path $solutionFolder -Include @("bin","obj","BuildOutput") -Recurse | % { Write-Output "Cleaning: $_"; Remove-Item $_ -Force -Recurse -ErrorAction SilentlyContinue }
}

Task Set-VersionNumber {
    # revision number can come from change set number or similar
	$revisionNo = 1
	Set-VersionNumber $solutionFolder $buildCounter $revisionNo $suffix
}

Task Invoke-UnitTests {
    $files = gci -Path $solutionFolder -Recurse -Filter "*.tests.dll" | where { $_.Fullname -notmatch "\\obj\\?" } | % { '"{0}"'  -f $_.FullName }
    $filesToTest = $files -join ' '
    Write-Host "Testing $filesToTest"

    & $nunitLocation $filesToTest /framework:net-4.0
} 