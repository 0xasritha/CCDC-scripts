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



# -----------------------------------------
Enumerate-AD