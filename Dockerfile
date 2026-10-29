FROM kivy/buildozer:latest

# Ensure git is installed (some buildozer recipes need it)
RUN apt-get update && apt-get install -y -q --no-install-recommends git && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

CMD ["buildozer", "android", "debug"]
