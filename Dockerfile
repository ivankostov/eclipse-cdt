FROM ubuntu:16.04
MAINTAINER Ivan Kostov "ikostov@gmail.com"

RUN apt-get update && apt-get install -y software-properties-common 

RUN apt-get update && apt-get install -y default-jre libxext-dev libxrender-dev libxtst-dev && \
    apt-get -y autoremove 

run apt-get update && apt-get install -y wget

RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module

RUN apt-get update && apt-get install -y g++ libboost-all-dev build-essential 

RUN wget http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/3/eclipse-cpp-neon-3-linux-gtk-x86_64.tar.gz  -O /tmp/eclipse.tar.gz -q && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

ADD run /usr/local/bin/eclipse

RUN chmod +x /usr/local/bin/eclipse && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    chown developer:developer -R /home/developer 

RUN mkdir -p /home/develop/workspace

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/local/bin/eclipse
