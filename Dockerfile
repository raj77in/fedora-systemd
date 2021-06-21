FROM fedora

## Original work by Dan Walsh @
## https://developers.redhat.com/blog/2014/05/05/running-systemd-within-docker-container
# MAINTAINER “Dan Walsh” <dwalsh@redhat.com>
MAINTAINER "Amit Agarwal" <amit.agarwal@mobileum.com> 

ENV container docker
RUN yum -y update; yum clean all
RUN yum -y install systemd openssh-server iproute procps-ng passwd; yum clean all;
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*; 
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
