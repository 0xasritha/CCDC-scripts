# TODO: make this into a Git Repo 

<# 
- TODO: test password changing script as well
- TODO:
- active RDP sessions 
- automated startup commands 
- change password policies 
- prevent against common NTLM + kerbeorsting attacks 
- look in AD security.org
- Disable old protocols (like SMB1)

from chat: 

Rotate-DomainPasswords.ps1
Get-ActiveSessions.ps1
Get-ListeningPorts.ps1
Kill-SuspiciousScheduledTasks.ps1
Disable-Delegation.ps1

Lock-RDP.ps1

Firewall-EgressBlock.ps1

Disable-SMB1.ps1

Get-ADAdminChanges.ps1

Emergency-HostIsolation.ps1
#>

Import-Module ActiveDirectory 

function Enumerate-AD { 
    # Forest (s)?: hostname, IP, OS/ other versions 
    Get-ADForest # only need some of the properties in default output of this command -> what is "name of forest" referring to? 

    # Get all domains in forest + thier child domains (so basically Get all domain trees) 



    # Get OUs 
    # added that are not the default OUs 

    # Get GPOs -> applied to which OUs? 
    # added that are not the default GPOs 
    # remove "DomainName" if there is only one domain name 
    Get-GPO -All | Select-Object DisplayName, DomainName, GpoStatus, Description  
}

Enumerate-AD

# ----------------------- GPOs 
# Figure out what GPOs are linked with what OUs 
Import-Module GroupPolicy
Import-Module ActiveDirectory

Get-GPO -All | ForEach-Object {
    $gpo = $_
    [xml]$report = Get-GPOReport -Guid $gpo.Id -ReportType Xml

    if ($report.GPO.LinksTo) {
        foreach ($ou in $report.GPO.LinksTo.SOMPath) {
            # WHICH ONES ARE THE DEFAULT ONES
            # - "Default Domain Policy" - linked to domain, applies to Authenticated Users 
            # - "Default Domain Controllers Policy": links to OU of domain controllers 
            # DID THE DEFAULT ONES HAVE THEIR SETTINGS CHANGED?
            Write-Host "GPO '$($gpo.DisplayName)' is linked to OU '$ou'"
        }
    }
}



# ----------------------- SMB Shares
# First get all server names (this is an example, adjust OU or filters as needed)
$Servers = Get-ADComputer -Filter 'OperatingSystem -Like "*Windows Server*"' | Select-Object -ExpandProperty Name

# Then loop through and get shares
foreach ($Server in $Servers) {
    Write-Host "Shares on $Server"
    Get-SmbShare -ComputerName $Server
}

<#

#>