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

# Windows Presentation Framework Doesn't Work but shows in different ways
    Get-Process | Out-Gridview # No cmdlet found
    Get-Help Get-Process -ShowWindow # No Error at all

# Credentials work, serialization, not so much
    $c = Get-Credential
    $c.GetNetworkCredential().Password

    # Non-Windows systems break down here
    $c | Export-Clixml -Path ~/cred.test.xml -force
    Import-Clixml -Path ~/cred.test.xml

# *nix / macOS to Windows remoting - not yet

# Install-Module not working yet, but...
    Install-Package -Name PoshRSJob, WFTools `
                    -Source https://www.powershellgallery.com/api/v2 `
                    -ProviderName NuGet `
                    -ExcludeVersion `
                    -Destination ~/.local/share/powershell/Modules/ `
                    -Force

# Jobs - most cmdlets work, apart from 'Start', so...
    Import-Module PoshRSJob -Force
    # Sleep for 10 seconds - should take ~ 10 seconds if parallel
    Measure-Command {
        1..10 |
        Start-RSJob -Throttle 11 {
            start-sleep -Seconds 5
        } |
        Wait-RSJob |
        Receive-RSJob
    }

# Some things work on any platform / .NET CLR, without modification
# PSScriptAnalyzer rules to tell us what will work, what won't should be coming
#    https://github.com/PowerShell/PSScriptAnalyzer/issues/605
#    If you use ISESteroids, this is already in place: http://www.powertheshell.com/powershellonlinux/
    Import-Module WFTools

    # Recurse through an object to see what properties and data it returns
    # Similar to Show-Object, but can simplify XML exploration, works on *nix
    Invoke-RestMethod "https://api.stackexchange.com/2.0/questions/unanswered?order=desc&sort=activity&tagged=powershell&pagesize=5&site=stackoverflow" |
        ConvertTo-FlatObject

# Wrap some Python!
    cd ~/sc/BPSUGDemoRepo/PSPyDemo/
    code ./docker-demo.sh
    # Kick off a container

    . "/source/BPSUGDemoRepo/PSPyDemo/Get-PyADObject.ps1"
    Get-PyADObject -SamAccountName wframe