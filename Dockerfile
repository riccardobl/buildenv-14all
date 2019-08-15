FROM ubuntu:bionic

# Based on crossbuild MAINTAINER Manfred Touron <m@42.am> (https://github.com/moul)

SHELL ["/bin/bash", "-c"]

RUN apt-get update&&apt-get upgrade -y

# Install deps
RUN set -x; \
    echo "deb [arch=arm64,ppc64el,armhf] http://ports.ubuntu.com/ubuntu-ports/ bionic main" > /etc/apt/sources.list.d/ubuntu-ports.list \
 && dpkg --add-architecture armel                      \
 && dpkg --add-architecture i386                       \
 && dpkg --add-architecture powerpc                    \
 && apt-get update                                     \
 && apt-get install -y -q                              \
        autoconf                                       \
        automake                                       \
        autotools-dev                                  \
        bc                                             \
        binfmt-support                                 \
        binutils-multiarch                             \
        binutils-multiarch-dev                         \
        build-essential                                \
        clang                                          \
        crossbuild-essential-arm64                     \
        crossbuild-essential-armel                     \
        crossbuild-essential-armhf                     \
        crossbuild-essential-ppc64el                   \
        curl                                           \
        devscripts                                     \
        gdb                                            \
        git                                       \
        libtool                                        \
        llvm                                           \
        mercurial                                      \
        multistrap                                     \
        patch                                          \
        software-properties-common                     \
        subversion                                     \
        wget                                           \
        xz-utils                                       \
        cmake                                          \
        qemu-user-static                               \
        ca-certificates \
        netbase \
        mercurial \
        bzr \
        openssh-client \
        procps \        
        curl \
        git-lfs \
        gnupg \
        unzip \
 && apt-get clean
 

# Install Windows cross-tools
RUN apt-get install -y mingw-w64 \
 && apt-get clean

RUN apt-get install -y libc6-dev-i386 libc6-i386 && apt-get clean

RUN git lfs install

# Install OSx cross-tools

#Build arguments
#ARG osxcross_repo="tpoechtrager/osxcross"
#ARG osxcross_revision="a845375e028d29b447439b0c65dea4a9b4d2b2f6"
#ARG darwin_sdk_version="10.10"
#ARG darwin_osx_version_min="10.6"
#ARG darwin_version="14"
#ARG darwin_sdk_url="https://www.dropbox.com/s/yfbesd249w10lpc/MacOSX${darwin_sdk_version}.sdk.tar.xz"

# ENV available in docker image
#ENV OSXCROSS_REPO="${osxcross_repo}"                   \
#    OSXCROSS_REVISION="${osxcross_revision}"           \
##    DARWIN_SDK_VERSION="${darwin_sdk_version}"         \
#    DARWIN_VERSION="${darwin_version}"                 \
#    DARWIN_OSX_VERSION_MIN="${darwin_osx_version_min}" \
#    DARWIN_SDK_URL="${darwin_sdk_url}"

#RUN mkdir -p "/tmp/osxcross"                                                                                   \
# && cd "/tmp/osxcross"                                                                                         \
# && curl -sLo osxcross.tar.gz "https://codeload.github.com/${OSXCROSS_REPO}/tar.gz/${OSXCROSS_REVISION}"  \
# && tar --strip=1 -xzf osxcross.tar.gz                                                                         \
# && rm -f osxcross.tar.gz                                                                                      \
# && curl -sLo tarballs/MacOSX${DARWIN_SDK_VERSION}.sdk.tar.xz                                                  \
#             "${DARWIN_SDK_URL}"                \
# && yes "" | SDK_VERSION="${DARWIN_SDK_VERSION}" OSX_VERSION_MIN="${DARWIN_OSX_VERSION_MIN}" ./build.sh                               \
# && mv target /usr/osxcross                                                                                    \
# && mv tools /usr/osxcross/                                                                                    \
# && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/omp                                                    \
# && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/osxcross-macports                                      \
# && ln -sf ../tools/osxcross-macports /usr/osxcross/bin/osxcross-mp                                            \
# && rm -rf /tmp/osxcross                                                                                       \
# && rm -rf "/usr/osxcross/SDK/MacOSX${DARWIN_SDK_VERSION}.sdk/usr/share/man"


# Create symlinks for triples and set default CROSS_TRIPLE
ENV LINUX_TRIPLES=arm-linux-gnueabi,arm-linux-gnueabihf,aarch64-linux-gnu,powerpc64le-linux-gnu                  
#ENV DARWIN_TRIPLES=x86_64h-apple-darwin${DARWIN_VERSION},x86_64-apple-darwin${DARWIN_VERSION},i386-apple-darwin${DARWIN_VERSION}  
ENV WINDOWS_TRIPLES=i686-w64-mingw32,x86_64-w64-mingw32                                                                           
ENV CROSS_TRIPLE=x86_64-linux-gnu

#$COPY ./assets/osxcross-wrapper /usr/bin/osxcross-wrapper



# Image metadata
CMD ["/bin/bash"]
WORKDIR /workdir

# Install Java
COPY ./assets/GetJava8.sh /tmp/GetJava8.sh
RUN chmod +x /tmp/GetJava8.sh 
ENV JAVA_HOME=/opt/java/jdk/lin64
ENV PATH="/opt/java/jdk/lin64/bin/:${PATH}"

# Linux 64 bit
RUN mkdir -p /opt/java/jdk/lin64 \
&& mkdir -p /opt/java/jre/lin64 \
&& /tmp/GetJava8.sh linux64 jdk /opt/java/jdk/lin64 \
&& /tmp/GetJava8.sh linux64 jre /opt/java/jre/lin64


# Windows 64 bit
RUN mkdir -p /opt/java/jdk/win64 \
&& mkdir -p /opt/java/jre/win64 \
&& /tmp/GetJava8.sh win64 jdk /opt/java/jdk/win64 \
&& /tmp/GetJava8.sh win64 jre /opt/java/jre/win64


# Install gradle
RUN curl https://downloads.gradle.org/distributions/gradle-5.5-bin.zip -o /tmp/gradle.zip
RUN if [ "`sha256sum /tmp/gradle.zip | cut -d' ' -f1`" != "8d78b2ed63e7f07ad169c1186d119761c4773e681f332cfe1901045b1b0141bc" ];\
    then \
        echo "Error. This version of gradle is corrupted."; \
        exit 1;\
    fi && \
    mkdir -p /tmp/gradle && \
    unzip -q -d /tmp/gradle /tmp/gradle.zip &&\
    cp -Rf /tmp/gradle/gradle-*/* / &&\
    rm -Rf /tmp/gradle && rm -f /tmp/gradle.zip && \
    echo "Installed gradle `gradle -v`"

RUN mkdir -p /cache
ENV GRADLE_USER_HOME=/cache/.gradle


RUN apt-get install -y libprotobuf-dev protobuf-compiler
