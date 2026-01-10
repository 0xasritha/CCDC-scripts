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
}



# -----------------------------------------
Enumerate-AD