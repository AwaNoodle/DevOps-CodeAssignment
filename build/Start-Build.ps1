param([string]$task = "Invoke-Compile", [string]$solutionFile = "", [string]$configMode = "Debug", [string]$buildCounter = "0", [string]$buildSuffix = "")

Write-Host "Current config"
Write-Host "task: $task"
Write-Host "solution: $solutionFile"
Write-Host "configMode: $configMode"
Write-Host "buildCounter: $buildCounter"
Write-Host "buildSuffix: $buildSuffix"

Import-Module "$PSScriptRoot\psake\psake.psm1"

Invoke-psake .\Start-BuildTasks.ps1 -t $task -framework '4.0' -parameters @{"p1"=$solutionFile;"p2"=$configMode;"p3"=$buildCounter;"p4"=$buildSuffix;} 

Remove-Module [p]sake -ErrorAction 'SilentlyContinue'

if ($Error -ne '') 
{ 
	Write-Host "$error"
    exit $error.Count
}