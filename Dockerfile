# Image
FROM ubuntu:24.04

# Run
RUN apt update
RUN apt install -y git sudo wget xz-utils
RUN rm -rf /var/lib/apt/lists/* # Clean Up
RUN useradd -m -s /bin/bash builder # Create Non-Root User
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/builder # No Password For Non-Root User

# Switch To Non-Root User
USER builder
WORKDIR /home/builder

# Default Command (Start Bash Shell)
CMD ["/bin/bash"]
