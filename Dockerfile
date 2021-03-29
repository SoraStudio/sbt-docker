FROM scratch
ADD rootfs.tar.xz /

ENV DEBIAN_FRONTEND noninteractive
ENV ORB_PORT=10000
ENV TANGO_HOST=127.0.0.1:${ORB_PORT}

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list


RUN mkdir /setup
WORKDIR /setup

RUN set -ex

RUN apt update
RUN apt install -y sudo
RUN apt install -y tango-common
RUN sudo apt install -y build-essential bison flex curl
RUN sudo apt install -y libgmp-dev libmpfr-dev libmpc-dev zlib1g-dev vim git default-jdk default-jre
# install sbt: https://www.scala-sbt.org/release/docs/Installing-sbt-on-Linux.html
RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
RUN sudo apt update
RUN sudo apt install -y sbt
RUN sudo apt install -y texinfo gengetopt
RUN sudo apt install -y libexpat1-dev libusb-dev libncurses5-dev cmake
# deps for poky
RUN sudo apt install -y python3.6 patch diffstat texi2html texinfo subversion chrpath git wget
# deps for qemu
RUN sudo apt install -y libgtk-3-dev gettext
# deps for firemarshal
RUN sudo apt install -y python3-pip python3-dev rsync libguestfs-tools expat ctags
# install DTC
RUN sudo apt install -y device-tree-compiler

RUN mkdir /workspace
WORKDIR /workspace

CMD [ "bash" ]