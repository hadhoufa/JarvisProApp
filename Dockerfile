# Use a pre-built image that already has Python, Java, and Buildozer
FROM kivy/buildozer:latest

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Run Buildozer
CMD ["buildozer", "android", "debug"]
