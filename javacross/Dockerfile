FROM riccardoblb/buildenv-14all:java

RUN  dpkg --add-architecture i386     

RUN apt-get install -y \
  gcc-multilib         \
&& apt-get clean

RUN apt-get install -y \
  libc6-dev-i386       \
  libc6-i386           \
  mingw-w64            \
&& apt-get clean


ENV JAVA_HOME_WINDOWS=/opt/java/jdk/win64
ENV JAVA_INCLUDE_WINDOWS=/opt/java/jdk/win64/include
ENV JAVA_INCLUDE_MD_WINDOWS=/opt/java/jdk/win64/include/win32

ENV JAVA_HOME_WINDOWS_32=/opt/java/jdk/win32
ENV JAVA_INCLUDE_WINDOWS_32=/opt/java/jdk/win32/include
ENV JAVA_INCLUDE_MD_WINDOWS_32=/opt/java/jdk/win32/include/win32

ENV JAVA_HOME_LINUX_32=/opt/java/jdk/lin32
ENV JAVA_INCLUDE_LINUX_32=/opt/java/jdk/lin32/include
ENV JAVA_INCLUDE_MD_LINUX_32=/opt/java/jdk/lin32/include/linux



ENV JAVA11_HOME_WINDOWS=/opt/java/jdk11/win64
ENV JAVA11_INCLUDE_WINDOWS=/opt/java/jdk11/win64/include
ENV JAVA11_INCLUDE_MD_WINDOWS=/opt/java/jdk11/win64/include/win32



RUN \
mkdir -p /opt/java/jdk/win64 \
&& mkdir -p /opt/java/jdk11/win64 \
\
&& mkdir -p /opt/java/jdk/lin32 \
&& mkdir -p /opt/java/jdk/win32 \
\
&& GetJava win64 jdk8 /opt/java/jdk/win64 \
&& GetJava win64 jdk11 /opt/java/jdk11/win64 \
\
&& GetJava linux32 jdk8 /opt/java/jdk/lin32 \
&& GetJava win32 jdk8 /opt/java/jdk/win32
