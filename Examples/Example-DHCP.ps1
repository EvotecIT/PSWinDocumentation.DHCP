$XmlCli = "$Env:USERPROFILE\Desktop\DHCP.xml"
$Html = "$Env:USERPROFILE\Desktop\DHCP.html"

if (Test-Path -LiteralPath $XmlCli) {

    $DHCPS = Import-Clixml -LiteralPath $XmlCli
    $DHCPS.Scopes | ft -AutoSize

    Dashboard -FilePath $Html -Show {
        Section {
            Table -DataTable $DHCPS.Scopes
        }
        Section {
            Table -DataTable $DHCPS.ScopesAll
        }
    }
} else {


    $DHCPS = Get-WinDHCP
    $DHCPS.ScopeAll | Format-Table -AutoSize
    $DHCPS.Scope | Format-Table -AutoSize
    $DHCPS | Export-CliXml -Path "$PSScriptRoot\DHCP.xml"

}