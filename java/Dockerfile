FROM riccardoblb/buildenv-14all:base

COPY tools/GetJava.sh /usr/bin/GetJava
RUN chmod +x /usr/bin/GetJava

ENV JAVA_HOME=/opt/java/jdk/lin64
ENV JAVA_INCLUDE=/opt/java/jdk/lin64/include
ENV JAVA_INCLUDE_MD=/opt/java/jdk/lin64/include/linux

ENV JAVA_HOME_LINUX=/opt/java/jdk/lin64
ENV JAVA_INCLUDE_LINUX=/opt/java/jdk/lin64/include
ENV JAVA_INCLUDE_MD_LINUX=/opt/java/jdk/lin64/include/linux

ENV JAVA11_HOME_LINUX=/opt/java/jdk11/lin64
ENV JAVA11_INCLUDE_LINUX=/opt/java/jdk11/lin64/include
ENV JAVA11_INCLUDE_MD_LINUX=/opt/java/jdk11/lin64/include/linux

ENV PATH="/opt/java/jdk/lin64/bin/:${PATH}"

# Java
RUN \
mkdir -p /opt/java/jdk/lin64 \
&& mkdir -p /opt/java/jdk11/lin64 \
\
&& GetJava linux64 jdk8 /opt/java/jdk/lin64 \
&& GetJava linux64 jdk11 /opt/java/jdk11/lin64

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
