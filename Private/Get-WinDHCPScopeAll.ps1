function Get-WinDHCPScopeAll {
    param(
        [string[]] $ComputerName
    )
    foreach ($Computer in $ComputerName) {
        $ServersScopeIPv4 = Get-WinDHCPScope -ComputerName $Computer
        foreach ($CurrentScope in $ServersScopeIPv4) {
            $ScopeInfo = Get-DhcpServerv4Scope -ComputerName $Computer -ScopeId $CurrentScope.ScopeId
            $ScopeStats = Get-DhcpServerv4ScopeStatistics -ComputerName $Computer -ScopeId $CurrentScope.ScopeId #| Select-Object ScopeID, AddressesFree, AddressesInUse, PercentageInUse, ReservedAddress
            $ScopeReserved = (Get-DhcpServerv4Reservation -ComputerName $Computer -ScopeId $CurrentScope.ScopeId).count

            [PSCustomObject] @{
                Server          = $Computer
                Name            = $ScopeInfo.Name
                ScopeId         = $ScopeInfo.ScopeID.IPAddressToString -join ', '
                State           = $ScopeInfo.State
                AddressesInUse  = $ScopeStats.AddressesInUse
                AddressesFree   = $ScopeStats.AddressesFree
                PercentageInUse = [System.Math]::Round($ScopeStats.PercentageInUse)
                Reserved        = $ScopeReserved
                SubnetMask      = $ScopeInfo.SubnetMask
                StartRange      = $ScopeInfo.StartRange
                EndRange        = $ScopeInfo.EndRange
                LeaseDuration   = $ScopeInfo.LeaseDuration
            }
        }
    }
}