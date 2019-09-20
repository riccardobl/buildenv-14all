FROM riccardoblb/buildenv-14all:java

RUN set -x; \
 echo "deb [arch=arm64,ppc64el,armhf] http://ports.ubuntu.com/ubuntu-ports/ bionic main" > /etc/apt/sources.list.d/ubuntu-ports.list \
 && dpkg --add-architecture armel                      \
 && dpkg --add-architecture i386                       \
 && dpkg --add-architecture powerpc                    

RUN apt install -y \
  gcc-multilib     \
  g++-multilib     \
&& apt-get clean

RUN apt install -y            \
  gcc-8-arm-linux-gnueabihf   \
  gcc-8-arm-linux-gnueabi     \
  gcc-8-aarch64-linux-gnu     \
  g++-8-arm-linux-gnueabihf   \
  g++-8-arm-linux-gnueabi     \
  g++-8-aarch64-linux-gnu     \
&& apt-get clean

# arm
ENV JAVA_HOME_LINUX_ARM=/opt/java/jdk/arm
ENV JAVA_INCLUDE_LINUX_ARM=/opt/java/jdk/arm/include
ENV JAVA_INCLUDE_MD_LINUX_ARM=/opt/java/jdk/arm/include/linux

ENV JAVA11_HOME_LINUX_ARM=/opt/java/jdk11/arm
ENV JAVA11_INCLUDE_LINUX_ARM=/opt/java/jdk11/arm/include
ENV JAVA11_INCLUDE_LINUX_ARM=/opt/java/jdk11/arm/include/linux

# armhf
ENV JAVA_HOME_LINUX_ARMHF=/opt/java/jdk/armhf
ENV JAVA_INCLUDE_LINUX_ARMHF=/opt/java/jdk/armhf/include
ENV JAVA_INCLUDE_MD_LINUX_ARMHF=/opt/java/jdk/armhf/include/linux

ENV JAVA11_HOME_LINUX_ARMHF=/opt/java/jdk11/armhf
ENV JAVA11_INCLUDE_LINUX_ARMHF=/opt/java/jdk11/armhf/include
ENV JAVA11_INCLUDE_MD_LINUX_ARMHF=/opt/java/jdk11/armhf/include/linux

# arm64
ENV JAVA_HOME_LINUX_ARM64=/opt/java/jdk/arm64
ENV JAVA_INCLUDE_LINUX_ARM64=/opt/java/jdk/arm64/include
ENV JAVA_INCLUDE_MD_LINUX_ARM64=/opt/java/jdk/arm64/include/linux

ENV JAVA11_HOME_LINUX_ARM64=/opt/java/jdk11/arm64
ENV JAVA11_INCLUDE_LINUX_ARM64=/opt/java/jdk11/arm64/include
ENV JAVA11_INCLUDE_MD_LINUX_ARM64=/opt/java/jdk11/arm64/include/linux


RUN \
mkdir -p /opt/java/jdk/arm64 \
&& mkdir -p /opt/java/jdk/armhf \
&& mkdir -p /opt/java/jdk/arm \
\
&& mkdir -p /opt/java/jdk11/arm64 \
&& mkdir -p /opt/java/jdk11/armhf \
&& mkdir -p /opt/java/jdk11/arm \
\
&& GetJava linuxArm64 jdk8 /opt/java/jdk/arm64 \
&& GetJava linuxArmHF jdk8 /opt/java/jdk/armhf \
&& GetJava linuxArm jdk8 /opt/java/jdk/arm \
\
&& GetJava linuxArm64 jdk11 /opt/java/jdk11/arm64 \
&& GetJava linuxArmHF jdk11 /opt/java/jdk11/armhf \
&& GetJava linuxArm jdk11 /opt/java/jdk11/arm 
