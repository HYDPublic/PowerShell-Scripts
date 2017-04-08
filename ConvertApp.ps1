# App Conversion Powershell script. Automates the manual commands you use 
# To convert Win32 apps to UWP using the Desktop Bridge.
#
# To execute, go to the top level of your app package directory (one above the AppxManifest.xml file)
# and run this script. This relies on the top level directory being named the same as the AppId

# if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
#     Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; 
#     exit
# }

# TODO optional params
# TODO run certutil as admin always? 
function ConvertApp {
    param([string]$name, [string]$publisher) 
    Write-Output "Name: $name, Publisher $publisher";
    # makeappx.exe pack /l /d ".\$name\" /p "$name.appx";
    
    # if ($publisher -ne $null) {
    #     # Can we run makecert with default "none" so no window pops up?
    #     makecert.exe -r -h 0 -n "CN=$publisher" -eku 1.3.6.1.5.5.7.3.3 -pe -sv "$name.pvk" "$name.cer";
    # } else {
    #     makecert.exe -r -h 0 -n "CN=$name" -eku 1.3.6.1.5.5.7.3.3 -pe -sv "$name.pvk" "$name.cer";
    # }
    # pvk2pfx.exe -pvk "$name.pvk" -spc "$name.cer" -pfx "$name.pfx";
    # certutil.exe -addStore TrustedPeople "$name.cer"
    # signtool.exe sign -f "$name.pfx" -fd SHA256 -v ".\$name.appx";
    # Write-Output "Finished!";
}

function Output-SalesTax
{
 param( [int]$Price, [int]$Tax )
 $Price + $Tax
}

# Passed an AppId
if ($args.Length -eq 0) {
    Write-Output "Please provide an AppId."
} elseif ($args.Length -eq 1) { 
    Write-Output "0: $args[0]"
    # ConvertApp($args[0]);
} elseif ($args.length -gt 1) {
    Write-Output "0: $args[0], 1 $args[1]";  
    # ConvertApp($args[0], $args[1]);
}