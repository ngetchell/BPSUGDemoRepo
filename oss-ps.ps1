# PowerShell works!
    # What commands are available?
    # With a name? with Uri parameter? For a module?
    Get-Command
    Get-Command -Name *-Object
    Get-Command -ParameterName Uri
    Get-Command -Module PackageManagement

    # Number of cmdlets
    # PowerShell v1 (Vista) = 129
    # PowerShell v5 [Win10] = 1,285
    # Linux v6.0.0 [CentOS] = ?
    Get-Command |
        Measure-Object |
        Select-Object -ExpandProperty Count

    # What modules are loaded?  Available?
    Get-Module
    Get-Module -ListAvailable

    # Get help for a command
    Get-Help Invoke-RestMethod -Full

    # See what type / members come back from Get-Process
    Get-Process | Get-Member

# Explore!
    dir ENV:
    $ENV:PSMODULEPATH -split ":"

    Get-Variable
    Get-Variable -Name Is*
    $PSVersionTable
    $PROFILE | Select *

    # New Built-In Variables
    $isLinux
    $isWindows
    $IsOSX
    $IsCoreCLR

# Some things might be case sensitive...
    $ENV:PSModulePath # nope nope nope
    # Tab Completion is still your friend
    $env:psmodulepath #Now Tab

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
