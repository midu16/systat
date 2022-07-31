FROM docker.io/library/centos:7
MAINTAINER midu@redhat.com
# upgrading the image and installing packages to the container
RUN yum upgrade -y && yum upgrade -y && yum install epel-release -y && yum install sysstat -y && yum install tcpdump -y && yum install tcpdump -y
# trim a little 
RUN yum autoremove -y 
CMD ["/bin/bash"]
