FROM centos:6.9

MAINTAINER Jim Sims <jim.sims@dell.com>

LABEL Description="Docker container to run Isilon InsightIQ"

# The shell installer for IIQ struggles with deps so we preinstall them
RUN yum update -y && yum install -y sudo blas blas-devel gcc-c++ lapack lapack-devel libgfortran libstdc++ nfs-utils openssl-devel postgresql93 postgresql93-devel postgresql93-libs postgresql93-server python python-devel readline sqlite sssd wkhtmltox zlib tar libXext fontconfig logrotate libX11 libXrender fipscheck-lib libedit && yum clean all

# Copy in the installer files.
# You can drop the latest IIQ .sh file here and it will get installed.
ADD files /installfiles

# Create the administrator user with no password.
# Use the docker_iiq.sh script to change the password.
RUN useradd administrator -G root,wheel && \
    (echo "administrator ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers)

USER administrator

# Runs the installer for IIQ
RUN sudo sh /installfiles/*.sh < /installfiles/answerfile

USER 0

# Exposes Ports for direct access
EXPOSE 443 80

# Adds the startup script and specifies run command
# Docker doesn't use init service, init.d scripts are not run
ADD run.sh /
ADD tunedb.sh /
ADD disable_ipv6.sh /
CMD ["/run.sh"]
