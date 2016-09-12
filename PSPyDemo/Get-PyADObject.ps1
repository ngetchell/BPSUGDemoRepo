# Illustrative purposes only
# Comment based help, less assumptions, more parameters, etc.

Function Get-PyADObject {
    [cmdletbinding()]
    param(
        $SamAccountName
    )
    $PythonScript = Join-Path $PSScriptRoot Get-PyADObject.py

    # Nothing fancy to call external programs.  This just works.
    $Accounts = python $PythonScript --search_filter "(samaccountname=$SamAccountName)"
        # Other options https://social.technet.microsoft.com/wiki/contents/articles/7703.powershell-running-executables.aspx

    # Join the text together, convert from json, select a few props
    $Accounts -join " " |
        ConvertFrom-Json |
        Select-Object @{l='DistinguishedName';e={$_.dn}},
                      @{l='mail';e={$_.attributes.mail}},
                      @{l='samaccountname';e={$_.attributes.samaccountname}},
                      @{l='objectSid';e={$_.attributes.objectSid}}
}

# Thought: Consider the portability of solutions like this.
#          Is Python 3 available? (Please... don't use 2...)
#          Do you need a virtual environment? (Yes)
#          Are the right libraries available?
#          Hence using Docker for the demo today : )

#          Binaries / compiled bits will likely be
#          a more portable option, if a bit more painful
#          to write and build (e.g. golang)