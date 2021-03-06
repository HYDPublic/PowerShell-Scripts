# App Conversion Powershell script. Automates the manual commands you use 
# To convert Win32 apps to UWP using the Desktop Bridge.
#
# To execute, go to the top level of your app package directory (one above the AppxManifest.xml file)
# and run this script. This relies on the top level directory being named the same as the AppId
#
# TODO run certutil as admin always? 
# TODO run makecert silently without private key password (or default none)

function ConvertApp ($name, $publisher) {
    makeappx.exe pack /l /d ".\$name\" /p "$name.appx";
    $val = If ($publisher -ne $null) {$publisher} else {$name}
    makecert.exe -r -h 0 -n "CN=$val" -eku 1.3.6.1.5.5.7.3.3 -pe -sv "$name.pvk" "$name.cer";

    pvk2pfx.exe -pvk "$name.pvk" -spc "$name.cer" -pfx "$name.pfx";
    certutil.exe -addStore TrustedPeople "$name.cer"
    signtool.exe sign -f "$name.pfx" -fd SHA256 -v ".\$name.appx";
    Write-Output "Finished!";
}

if ($args.Length -eq 0) { # Passed nothing.
    Write-Output "Please provide an AppId.";
} else {
    ConvertApp $args[0] $args[1]
}