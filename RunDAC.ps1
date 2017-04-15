# Shortcut for running the DAC tool, just pass appropriate file names

function RunDAC($installer, $destination, $name, $publisher, $version) {
    Write-Output "Installer = $installer"
    Write-Output "Destination = $destination"
    Write-Output "PackageName = $name"
    Write-Output "Publisher = $publisher"
    Write-Output "Version = $version"    
    
    DesktopAppConverter.exe `
        -Installer $installer `
        -InstallerArguments "/S /silent /quiet /log <log_folder>\install.log" `
        -Destination $destination `
        -Sign `
        -MakeAppx `
        -Verbose `
        -Version $version `
        -PackageName $name `
        -Publisher "CN=$publisher" `
}

if ($args.Length -eq 5) {
    RunDAC $args[0] $args[1] $args[2] $args[3] $args[4]
} else {
    Write-Output "Missing Parameters. Required are:"
    Write-Output "-Installer"
    Write-Output "-Destination"
    Write-Output "-PackageName"
    Write-Output "-Publisher"
    Write-Output "-Version"
}