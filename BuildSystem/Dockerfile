# Image
FROM ubuntu:24.04

# Run
RUN apt update
RUN apt install -y \
  build-essential  \
  chrpath          \
  cpio             \
  debianutils      \
  diffstat         \
  file             \
  gawk             \
  gcc              \
  git              \
  iputils-ping     \
  iproute2         \
  liblz4-tool      \
  libsdl1.2-dev    \
  locales          \
  mesa-common-dev  \
  pylint           \
  python3          \
  python3-git      \
  python3-jinja2   \
  python3-pexpect  \
  python3-pip      \
  python3-subunit  \
  socat            \
  sudo             \
  texinfo          \
  unzip            \
  wget             \
  xterm            \
  xz-utils         \
  zstd
RUN rm -rf /var/lib/apt/lists/* # Clean Up
RUN useradd -m -s /bin/bash builder # Create Non-Root User
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/builder # No Password For Non-Root User

# Set Locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Switch To Non-Root User
USER builder
WORKDIR /home/builder

# Default Command (Start Bash Shell)
CMD ["/bin/bash"]
