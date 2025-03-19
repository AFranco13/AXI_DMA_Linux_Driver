FROM  	ubuntu:18.04

LABEL 	maintainer="alejandro.f.g@hotmail.com"

ENV 	DEBIAN_FRONTEND=noninteractive
ENV 	LC_ALL=en_US.UTF-8 
ENV 	LANG=en_US.UTF-8 
ENV 	LANGUAGE=en_US.UTF-8 
ENV 	TZ=Europe/Madrid

ARG 	installer_url="172.17.0.1:8000"
ARG 	version=2020.2
ARG 	user=plnx

RUN 	adduser --disabled-password --gecos '' $user

RUN 	mkdir -p /opt/petalinux /home/$user/project

RUN 	chown -R $user:$user /opt/petalinux /home/$user/project

# using local mirror to speed up
# COPY /etc/apt/sources.list /etc/apt/sources.list
#COPY 	sources.list /etc/apt/sources.list

RUN 	dpkg --add-architecture i386 	
RUN    	apt-get update -y 		
RUN    	apt-get clean all 		
RUN    	apt-get install -y -qq 
# RUN    	apt-get install -y -qq  iputils
RUN    	apt-get install -y -qq  sudo 
RUN    	apt-get install -y -qq  rsync 
# RUN    	apt-get install -y -qq  apt-utils 
RUN    	apt-get install -y -qq  x11-utils

# Required tools and libraries of Petalinux.
# See in: ug1144-petalinux-tools-reference-guide, 2018.2
RUN 	apt-get update

RUN     apt-get install -y -qq iproute2 gawk python3 python build-essential gcc git make net-tools libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg wget git-core diffstat chrpath socat xterm autoconf libtool tar unzip texinfo zlib1g-dev gcc-multilib automake zlib1g:i386 screen pax gzip cpio python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3
	# Using expect to install Petalinux automatically.
RUN     apt-get install -y -qq expect
# bash is PetaLinux recommended shell
RUN 	ln -fs /bin/bash /bin/sh    

RUN 	echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER 	$user

RUN 	echo "source /opt/petalinux/settings.sh" >> ~/.bashrc

WORKDIR /home/$user/project

COPY 	noninteractive-install.sh .

RUN 	wget -q 172.17.0.1:8000/petalinux-v${version}-final-installer.run

RUN	chmod a+x petalinux-v${version}-final-installer.run

RUN     ./noninteractive-install.sh /opt/petalinux ${version}

#RUN rm -rf petalinux-v2019.1-final-installer.run

#RUN 	rm noninteractive-install.sh *log               			
