FROM centos:7

MAINTAINER Jim Sims <jim.sims@dell.com>

LABEL Description="Docker container to run Isilon InsightIQ"

RUN yum install -y \
        sudo initscripts

RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

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
#ADD run.sh /
#ADD tunedb.sh /
#ADD disable_ipv6.sh /
#CMD ["/run.sh"]
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
