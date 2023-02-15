FROM docker.io/library/centos:7
MAINTAINER midu@redhat.com
# upgrading the image and installing packages to the container
RUN yum upgrade -y && yum upgrade -y && yum install epel-release -y && yum install sysstat -y && yum install tcpdump tcptraceroute wireshark sudo -y && yum install python3 -y
# adding the ptp.py script in the image
COPY ptp.py /ptp.py
# trim a little 
RUN yum autoremove -y

# Building Valgrind
WORKDIR /
RUN curl -O -L https://sourceware.org/pub/valgrind/valgrind-3.20.0.tar.bz2 && bzip2 -d valgrind-3.20.0.tar.bz2  && tar -xf valgrind-3.20.0.tar
WORKDIR /valgrind-3.20.0
RUN ./configure && make && make install

# creating the admin user
RUN useradd -ms /bin/bash admin
# adding the admin user to 'sudo' group
RUN usermod -a -G root admin
# adding the admin user to 'wireshark' group
RUN usermod -a -G wireshark admin
# sudoers.d/admin creation
RUN mkdir -p /etc/sudoers.d/ && echo "admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin
RUN chmod 044 /etc/sudoers.d/admin
# switching to admin user
USER admin
# switching to admin homedirectory
WORKDIR /home/admin


CMD ["/bin/bash"]
