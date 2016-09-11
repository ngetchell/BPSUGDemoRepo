# Explore!
    dir ENV:
    $ENV:PSMODULEPATH

    Get-Variable
    Get-Variable -Name Is*
    $PSVersionTable
    $PROFILE | Select *

# Some things might be case sensitive...
    $ENV:PSModulePath # nope nope nope

# Credentials work, serialization, not so much
    $c = Get-Credential
    $c.GetNetworkCredential().Password

    # Non-Windows systems break down here
    $c | Export-Clixml -Path ~/cred.test.xml -force
    Import-Clixml -Path ~/cred.test.xml

# *nix / macOS to Windows remoting - not yet

# Install-Module not working yet, but...
    Install-Package -Name PoshRSJob `
                    -Source https://www.powershellgallery.com/api/v2 `
                    -ProviderName NuGet `
                    -ExcludeVersion `
                    -Destination ~/sc/psvenv/

# Jobs - work, apart from 'Start', but...
    Import-Module ~/sc/psvenv/PoshRSJob -Force
    # Sleep for 10 seconds - should take ~ 10 seconds if parallel
    Measure-Command {
        1..10 |
        Start-RSJob {
            start-sleep -Seconds 10
        } -Throttle 11 |
        Wait-RSJob |
        Receive-RSJob
    }

# Wrap some Python!



