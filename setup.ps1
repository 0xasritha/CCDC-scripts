Install-ADDSDomain `
    -DomainName "child.parentdomain.com" `
    -ParentDomainName "parentdomain.com" `
    -NewDomainNetBIOSName "CHILD" `
    -Credential $credential `
    -InstallDNS:$true `
    -NoRebootOnCompletion:$false `
    -IsChildDomain:$true


