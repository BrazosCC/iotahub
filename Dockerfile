FROM ubuntu:18.04

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
		gcc-7 \
		pkg-config \
		zip \
		g++ \
		zlib1g-dev \
		unzip \
		python \
		python-pyparsing \
		git \
		mariadb-client

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
		wget

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser && \
	mkdir -p /home/appuser && \
	chown appuser:appuser /home/appuser

USER appuser
WORKDIR /home/appuser
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.18.0/bazel-0.18.0-installer-linux-x86_64.sh
RUN chmod +x bazel-0.18.0-installer-linux-x86_64.sh
RUN ./bazel-0.18.0-installer-linux-x86_64.sh --user

RUN git clone https://github.com/iotaledger/rpchub.git hub
WORKDIR /home/appuser/hub

ENV PATH="/home/appuser/bin:${PATH}"
RUN bazel build -c opt //hub:hub

COPY standalone.sh /home/appuser/bin/
COPY remote_sign.sh /home/appuser/bin/

EXPOSE 50051
VOLUME /ssl

WORKDIR /home/appuser/hub
CMD standalone.sh