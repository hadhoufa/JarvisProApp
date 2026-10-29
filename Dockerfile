FROM kivy/buildozer:latest

# Force non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_INPUT=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV DEBCONF_NONINTERACTIVE_SEEN=true

# Ensure git is installed
RUN apt-get update && apt-get install -y -q --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Run buildozer
CMD ["buildozer", "android", "debug"]
