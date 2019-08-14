Get-DnsClientServerAddress | % {
    $interfaceName = $_.InterfaceAlias
    $bluetoothRegex = [regex]".Bluetooth.*"
    $teredoRegex = [regex]".*Teredo.*"
    $loopbackRegex = [regex]".*Loopback.*"
    $localRegex = [regex]".*local\*.*"
    if (($interfaceName -notmatch $bluetoothRegex) -and ($interfaceName -notmatch $teredoRegex) -and ($interfaceName -notmatch $loopbackRegex) -and ($interfaceName -notmatch $localRegex) ) {
        if ($_.AddressFamily -eq "23") {
            Set-DnsClientServerAddress -InterfaceAlias $interfaceName -Validate -ServerAddresses "2606:4700:4700::1111,2606:4700:4700::1001"
            Write-Output "Setting DNS to CloudFlare for "$interfaceName" in "IPv6
        }
        elseif ($_.AddressFamily -eq "2") {
            Set-DnsClientServerAddress -InterfaceAlias $interfaceName -Validate -ServerAddresses "1.1.1.1,1.0.0.1"
            Write-Output "Setting DNS to CloudFlare for "$interfaceName" in "IPv4
        }
    }
}
Pause

function Pause ($Message = "Press any key to continue...") {
    Write-Host -NoNewLine $Message;
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}