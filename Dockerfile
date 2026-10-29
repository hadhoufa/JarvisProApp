FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=user
ENV HOME_DIR=/home/user
ENV WORK_DIR=/app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip python3-venv python3-dev \
    openjdk-17-jdk git zip unzip \
    autoconf libtool pkg-config zlib1g-dev \
    libncurses5-dev libncursesw5-dev libtinfo5 \
    cmake libffi-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create user and venv
RUN useradd -m -d $HOME_DIR $USER
RUN python3 -m venv $HOME_DIR/.venv
ENV PATH="$HOME_DIR/.venv/bin:$PATH"

# Install buildozer and cython
RUN pip install --upgrade pip wheel setuptools
RUN pip install buildozer "cython<3.0"

WORKDIR $WORK_DIR
COPY . $WORK_DIR

CMD ["buildozer", "android", "debug"]
