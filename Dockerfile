FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
  sudo \
  curl \
  wget \
  git \
  python3 \
  python3-pip \
  openjdk-11-jdk \
  build-essential \
  nodejs \
  npm

# Create a non-root user and grant sudo privileges
RUN useradd -ms /bin/bash vscode \
  && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Cloud9
RUN npm install -g c9

# Set the working directory
WORKDIR /home/vscode

# Switch to the non-root user
USER vscode

# Expose the Cloud9 port
EXPOSE 8080

CMD ["c9", "start", "--listen", "0.0.0.0", "--port", "8080", "--workspace", "/home/vscode/workspace"]
