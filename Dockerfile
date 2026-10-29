FROM ubuntu:22.04

# Install liberror-perl first with inline non-interactive mode (The REAL Fix)
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -q liberror-perl

# Install the rest of the dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -q --no-install-recommends \
    python3 python3-pip python3-venv \
    openjdk-17-jdk \
    build-essential git zip unzip \
    lib32stdc++6 lib32z1 lib32ncurses6 \
    libltdl-dev autoconf automake libtool pkg-config \
    zlib1g-dev libncurses5-dev libncursesw5-dev \
    cmake libffi-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip==23.3.2
RUN pip3 install cython==0.29.34 buildozer

WORKDIR /app
COPY . /app

RUN chmod -R 777 /app

CMD ["buildozer", "android", "debug"]
