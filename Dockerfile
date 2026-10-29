FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Prevent systemd/resolv.conf issues

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    openjdk-17-jdk \
    build-essential git zip unzip --no-install-recommends \
    lib32stdc++6 lib32z1 lib32ncurses6 \
    libltdl-dev autoconf automake libtool pkg-config \
    zlib1g-dev libncurses5-dev libncursesw5-dev \
    cmake libffi-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip==23.3.2
RUN pip3 install cython==0.29.34 buildozer

WORKDIR /app
COPY . /app

CMD ["buildozer", "android", "debug"]
