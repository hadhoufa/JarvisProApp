FROM kivy/buildozer:latest

# Force non-interactive mode for apt and pip (The REAL Fix)
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_INPUT=1

# Ensure git is installed (non-interactively)
RUN apt-get update && apt-get install -y -q --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# Run buildozer (it will now run in non-interactive mode)
CMD ["buildozer", "android", "debug"]
