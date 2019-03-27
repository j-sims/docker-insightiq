FROM centos:6.9

MAINTAINER Claudio Fahey <claudio.fahey@dell.com>

LABEL Description="Docker container to run Isilon InsightIQ"

RUN yum install -y \
        sudo

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
CMD ["/run.sh"]
