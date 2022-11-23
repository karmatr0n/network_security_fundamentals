# libssh server vulnerable to cve-2018-10933 with a simple PoC demo
FROM ubuntu:xenial
ADD libssh-0.8.3.tar.xz /root
ADD cve-2018-10933.patch /root
ADD server.patch /root
RUN apt-get update --assume-yes &&\
    apt-get upgrade --assume-yes &&\
    apt-get install vim zlib1g zlib1g-dev libssl-dev openssh-client cmake build-essential neovim--assume-yes &&\
    cp -r /root/libssh-0.8.3 /root/exploit-libssh-0.8.3 &&\
    cd /root/libssh-0.8.3 &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make &&\
    make install &&\
    cd examples &&\
    make &&\
    cd /root/exploit-libssh-0.8.3 &&\
    patch -p0 < /root/cve-2018-10933.patch &&\
    patch -p0 < /root/server.patch &&\
    mkdir build && \
    cd build && \
    cmake .. && \
    make &&\
    make install &&\
    cd /root &&\
    ssh-keygen -t dsa -f ssh_host_dsa_key -N '' &&\
    ssh-keygen -t rsa -b 2048 -f ssh_host_rsa_key -N '' 
EXPOSE 22
ENTRYPOINT ["/root/exploit-libssh-0.8.3/build/examples/ssh_server_fork", "-d", "/root/ssh_host_dsa_key", "-k", "/root/ssh_host_rsa_key", "-p", "22", "-v", "0.0.0.0" ]
