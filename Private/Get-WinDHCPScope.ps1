function Get-WinDHCPScope {
    param(
        [string[]] $ComputerName
    )
    foreach ($Computer in $ComputerName) {
        try {
            $Scopes = Get-DhcpServerv4Scope -ComputerName $Computer -ErrorAction Stop
        } catch {
            $ErrorMessage = $_.Exception.Message -replace "`n", " " -replace "`r", " "
            Write-Warning "Get-WinDHCPScope - Getting DHCP from $Computer failed. Error: $ErrorMessage"
        }
        foreach ($Scope in $Scopes) {
            [PSCustomObject] @{
                Server           = $Computer
                ScopeId          = $Scope.ScopeId
                SubnetMask       = $Scope.SubnetMask
                StartRange       = $Scope.StartRange
                EndRange         = $Scope.EndRange
                ActivatePolicies = $Scope.ActivatePolicies
                Delay            = $Scope.Delay
                Description      = $Scope.Description
                LeaseDuration    = $Scope.LeaseDuration
                MaxBootpClients  = $Scope.MaxBootpClients
                Name             = $Scope.Name
                NapEnable        = $Scope.NapEnable
                NapProfile       = $Scope.NapProfile
                State            = $Scope.State
                SuperscopeName   = $Scope.SuperscopeName
                Type             = $Scope.Type
                Comment          = $ErrorMessage
            }
        }
    }
}