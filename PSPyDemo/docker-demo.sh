# Assumptions:
# I've installed Docker and docker machine if necessary
    # Windows: https://docs.docker.com/engine/installation/windows/
        # Already have Hyper-V enabled?  You can still run VirtualBox (included in toolbox if you don't have it already):
        # http://www.hanselman.com/blog/SwitchEasilyBetweenVirtualBoxAndHyperVWithABCDEditBootEntryInWindows81.aspx
    # macOS:   https://docs.docker.com/engine/installation/mac/

# If using docker machine, I've created a default machine
   # After the install, 'Docker Quickstart Terminal' will create this for you
   # Or you can create it manually...

# Build the docker image, run it
docker build --no-cache=true -t wframe/pspydemo .
docker run -v ~/sc:/source -it wframe/pspydemo

# We're in a container!
# Activate the pyvenv virtual environment...
source bin/activate

# PowerShell!
powershell