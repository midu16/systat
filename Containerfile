FROM docker.io/library/centos:7
MAINTAINER midu@redhat.com
# upgrading the image and installing packages to the container
RUN yum upgrade -y
RUN yum upgrade -y
RUN yum install epel-release -y
RUN yum install sysstat -y 
RUN yum install tcpdump -y
# trim a little 
RUN yum autoremove -y 
CMD ["/bin/bash"]
