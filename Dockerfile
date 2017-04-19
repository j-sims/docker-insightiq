FROM centos:6
MAINTAINER Jim Sims <jim.sims@isilon.com>

LABEL Description="Docker container to run Isilon InsightIQ"

# Update to latest CentOS Version
RUN yum -y update
RUN yum -y upgrade

# Install IIQ Dependencies
RUN yum install -y blas blas-devel gcc-c++ lapack lapack-devel libgfortran libstdc++ nfs-utils openssh-clients openssl-devel postgresql93 postgresql93-devel postgresql93-libs postgresql93-server python python-devel readline sqlite sssd wkhtmltox zlib tar openssh 

# IIQ Install hardcodes the version of openssh, to avoid error we remove openssh
RUN yum remove -y openssh

# Create the installer files dir
RUN mkdir /installfiles

# Copy in the installer files
# You can drop the latest IIQ .sh file here and it will get installed
# Does not handle upgrades
ADD files /installfiles

# Runs the installer for IIQ
RUN  /installfiles/*.sh < /installfiles/answerfile

# Create the administrator user with default passwd
# Use the docker_iiq.sh script to change the password
RUN useradd administrator
RUN echo a | /usr/bin/passwd administrator --stdin

# Exposes Ports for direct access
EXPOSE 443 80

# Adds the startup script and specifies run command
# Docker doesn't use init service, init.d scripts are not run
ADD run.sh /
CMD ["/bin/bash", "/run.sh"]


