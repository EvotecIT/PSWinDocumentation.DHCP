function Get-WinDHCPServers {
    param(

    )
    $Servers = Get-DhcpServerInDC
    return $Servers.DnsName
}