#To Assign Static IP to Domain Controller's vEthernet
New-NetIPAddress -InterfaceAlias "vEthernet (InternalNATSwitch)" -IPAddress 192.168.200.1 -PrefixLength 24
Set-DnsClientServerAddress -InterfaceAlias "Internal (Domain Network)" -ServerAddresses 127.0.0.1

#To Assign Static IP to Nested Windows Server 2019
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.200.12 -PrefixLength 24 -DefaultGateway 192.168.200.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.200.1

#To Assign Static IP to Nested Windows 11
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.200.13 -PrefixLength 24 -DefaultGateway 192.168.200.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.200.1







 