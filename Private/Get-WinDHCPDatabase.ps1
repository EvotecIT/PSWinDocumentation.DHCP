function Get-WinDHCPDatabase {
    param(
        [string[]] $ComputerName
    )
    foreach ($Computer in $ComputerName) {
        try {
            $Database = Get-DhcpServerDatabase  -ComputerName $Computer -ErrorAction Stop
        } catch {
            $ErrorMessage = $_.Exception.Message -replace "`n", " " -replace "`r", " "
            Write-Warning "Get-WinDHCPScope - Getting DHCP Database from $Computer failed. Error: $ErrorMessage"
        }
        if ($Database) {
            [PSCustomObject] @{
                Server                 = $Computer
                FileName               = $Database.FileName
                BackupPath             = $Database.BackupPath
                BackupIntervalMinutes  = $Database.'BackupInterval(m)'
                CleanupIntervalMinutes = $Database.'CleanupInterval(m)'
                LoggingEnabled         = $Database.LoggingEnabled
                RestoreFromBackup      = $Database.RestoreFromBackup
            }
        }
    }
}