# Remove existing NAT if needed (optional safety check)
$OldNat = Get-NetNat | Where-Object { $_.Name -eq "InternalNAT" }
if ($OldNat) {
    Remove-NetNat -Name "InternalNAT" -Confirm:$false
}

# Set static IP on Internal Adapter
New-NetIPAddress -InterfaceAlias "vEthernet (InternalNATSwitch)" -IPAddress 192.168.200.1 -PrefixLength 24

# Set DNS to local DC
Set-DnsClientServerAddress -InterfaceAlias "vEthernet (InternalNATSwitch)" -ServerAddresses 127.0.0.1

# Create new NAT for internal network
New-NetNat -Name "InternalNAT" -InternalIPInterfaceAddressPrefix "192.168.200.0/24"
