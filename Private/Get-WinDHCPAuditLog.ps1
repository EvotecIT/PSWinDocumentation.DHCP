function Get-WinDHCPAutidLog {
    param(
        [string[]] $ComputerName
    )
    foreach ($Computer in $ComputerName) {
        try {
            $Audit = Get-DhcpServerAuditLog -ComputerName $Computer -ErrorAction Stop
        } catch {
            $ErrorMessage = $_.Exception.Message -replace "`n", " " -replace "`r", " "
            Write-Warning "Get-WinDHCPScope - Getting DHCP AuditLog from $Computer failed. Error: $ErrorMessage"
        }
        if ($Audit) {
            [PSCustomObject] @{
                Server            = $Computer
                DiskCheckInterval = $Audit.DiskCheckInterval
                Enable            = $Audit.Enable
                MaxMBFileSize     = $Audit.MaxMBFileSize
                MinMBDiskSpace    = $Audit.MinMBDiskSpace
                Path              = $Audit.Path
            }
        }
    }
}