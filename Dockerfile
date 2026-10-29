FROM kivy/buildozer:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_INPUT=1
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /app
COPY . /app

# Use the custom entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
