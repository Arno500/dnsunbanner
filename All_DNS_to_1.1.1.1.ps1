Get-DnsClientServerAddress | % {
    $interfaceName = $_.InterfaceAlias
    $bluetoothRegex = [regex]".Bluetooth.*"
    $teredoRegex = [regex]".*Teredo.*"
    $loopbackRegex = [regex]".*Loopback.*"
    $localRegex = [regex]".*local\*.*"
    if (($interfaceName -notmatch $bluetoothRegex) -and ($interfaceName -notmatch $teredoRegex) -and ($interfaceName -notmatch $loopbackRegex) -and ($interfaceName -notmatch $localRegex) ) {
       echo "Setting DNS to CloudFlare for " + $interfaceName
       Set-DnsClientServerAddress -InterfaceAlias $interfaceName -Validate -ServerAddresses "1.1.1.1,1.0.0.1,2606:4700:4700::1111,2606:4700:4700::1001"
    }
}
Pause

function Pause ($Message="Press any key to continue...")
{
Write-Host -NoNewLine $Message;
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}