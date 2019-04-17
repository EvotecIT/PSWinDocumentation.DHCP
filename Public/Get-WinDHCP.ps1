function Get-WinDHCP {
    param(
        [string[]] $ComputerName,
        [switch] $Split
    )
    if ($ComputerName.Count -eq 0) {
        $ComputerName = Get-WinDHCPServers
        if ($ComputerName.Count -eq 0) {
            Write-Warning 'Get-WinDHCP - No computers with DHCP services found in domain.'
            return
        }
    }

    $DHCP = [ordered] @{}
    $DHCP.Computers = @{}
    if ($Split) {
        foreach ($Computer in $ComputerName) {
            $DHCP.Servers.$Computer = [ordered] @{}
            $DHCP.Servers.$Computer.Scopes = Get-WinDHCPScope -ComputerName $ComputerName
            $DHCP.Servers.$Computer.ScopesAll = Get-WinDHCPScopeAll -ComputerName $ComputerName
            $DHCP.Servers.$Computer.AuditLog = Get-WinDHCPAutidLog -ComputerName $ComputerName
            $DHCP.Servers.$Computer.Database = Get-WinDHCPDatabase -ComputerName $ComputerName
        }
    }
    $DHCP.Scopes = Get-WinDHCPScope -ComputerName $ComputerName
    $DHCP.ScopesAll = Get-WinDHCPScopeAll -ComputerName $ComputerName
    $DHCP.AuditLog = Get-WinDHCPAutidLog -ComputerName $ComputerName
    $DHCP.Database = Get-WinDHCPDatabase -ComputerName $ComputerName
}