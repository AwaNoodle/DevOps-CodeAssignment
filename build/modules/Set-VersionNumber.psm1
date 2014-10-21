$VersionRegex = "(\d+\.\d+\.\d+\.\d+)"

function Set-VersionNumber($basePath, $buildNumber, $revisionNumber, $packageSuffix)
{
    Write-Host "Searching for version files in $basePath"
    $files = gci -Path $basePath -Recurse -include "AssemblyInfo.*"

    $newVersionPart = "$buildNumber.$revisionNumber"
    Write-Host "Setting version parts to $newVersionPart"

    if($files.Count -eq 0)
    {
        Write-Warning "No version info files found"
        return
    }

    foreach ($file in $files)
    {
        $versionMajorMinor = "98.89"
        $fileContent = Get-Content($file)
        $fileContent | % { if($_ -match $VersionRegex) 
        { 
            $splits = $Matches[1].Split('.')[0,1]
            $versionMajorMinor = $splits[0] + "." + $splits[1]
        }}
        
        $suffix = ""
        if(($packageSuffix -ne $null) -And ($packageSuffix -ne ""))
        {
            $suffix = "-" + $packageSuffix
        }

        $newVersion = $versionMajorMinor + "." + $newVersionPart + $suffix
        attrib $file -r
        $filecontent -replace $VersionRegex, $newVersion | Out-File $file
        
        Write-Host "Updated $file to version $newVersion"
    }
}