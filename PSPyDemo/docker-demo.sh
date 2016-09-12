# Assumptions:
    # Install Docker or (if necessary) Docker Toolbox
        # Windows: https://docs.docker.com/engine/installation/windows/
            # Already have Hyper-V enabled?  You can still run VirtualBox (included in toolbox if you don't have it already):
            # http://www.hanselman.com/blog/SwitchEasilyBetweenVirtualBoxAndHyperVWithABCDEditBootEntryInWindows81.aspx
        # macOS:   https://docs.docker.com/engine/installation/mac/

    # If using docker machine, create a default machine
       # After the install, 'Docker Quickstart Terminal' will create this for you
       # Or you can create it manually...
       # eval "$(docker-machine env default)"

    # Navigate to path with Dockerfile

    # This might just be me, but this demo is pretty ugly on Windows 8.1 with Docker Toolbox...

# Pull the docker image - this takes a little while
# Read the Dockerfile to see what's included
docker pull -t ramblingcookiemonster/pspydemo

# Kick off a container using the image we built. Should be fast!
docker run -v ~/sc:/source -it ramblingcookiemonster/pspydemo
# On Windows, I skipped over mapping the folder:
docker run -it ramblingcookiemonster/pspydemo

# We're in a container!
# Activate the pyvenv virtual environment...
source bin/activate

# PowerShell!
powershell

# Back to OSS-ps.ps1