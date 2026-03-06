# Image
FROM ubuntu:24.04

# Run
RUN apt update
RUN apt install -y bison device-tree-compiler flex gcc git libgnutls28-dev libncurses-dev libssl-dev make python3 python3-dev python3-jsonschema python3-setuptools python3-yaml sudo swig wget xz-utils yamllint
RUN rm -rf /var/lib/apt/lists/* # Clean Up
RUN useradd -m -s /bin/bash builder # Create Non-Root User
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/builder # No Password For Non-Root User

# Switch To Non-Root User
USER builder
WORKDIR /home/builder

# Default Command (Start Bash Shell)
CMD ["/bin/bash"]
