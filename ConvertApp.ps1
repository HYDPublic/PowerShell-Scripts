# App Conversion Powershell script. Automates the manual commands you use 
# To convert Win32 apps to UWP using the Desktop Bridge.
#
# To execute, go to the top level of your app package directory (one above the AppxManifest.xml file)
# and run this script. This relies on the top level directory being named the same as the AppId

# if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; 
#     exit
# }

# Figure out optional params
function ConvertApp ([string]$name) {
    makeappx.exe pack /d ".\$name\" /p "$name.appx" /l;
    makecert.exe -r -h 0 -n "CN=$name" -eku 1.3.6.1.5.5.7.3.3 -pe -sv "$name.pvk" "$name.cer";
    pvk2pfx.exe -pvk "$name.pvk" -spc "$name.cer" -pfx "$name.pfx";
    certutil.exe -addStore TrustedPeople "$name.cer"
    signtool.exe sign -f "$name.pfx" -fd SHA256 -v ".\$name.appx";
    Write-Output "Finished!";
}

# Passed an AppId
if ($args.Length -eq 1) { 
    ConvertApp($args[0]);
} elseif ($args.length -gt 1) {
    # TODO allow for separate publisher name to be passed.
}