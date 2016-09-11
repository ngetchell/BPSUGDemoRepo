FROM centos:latest
MAINTAINER Warren Frame

#docker run -v ~/:/home -it centos:latest /bin/bash
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y install yum-utils

# Grab some Python goodies
RUN yum -y groupinstall development && \
    yum -y install https://centos7.iuscommunity.org/ius-release.rpm && \
    yum -y install python35u-3.5.2 && \
    yum -y install python35u-pip && \
    yum -y install python35u-devel && \
    pip3.5 install ldap3

# We're not animals, use a venv
RUN mkdir /source/environments -p && \
    pyvenv-3.5 /source/environments/PSPyExample && \
    source /source/environments/PSPyExample/bin/activate

# PowerShell time!
RUN yum -y install https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.9/powershell-6.0.0_alpha.9-1.el7.centos.x86_64.rpm

# Wrap up
RUN yum clean all
WORKDIR /source
CMD [ "/usr/bin/powershell" ]