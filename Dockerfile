FROM ubuntu:18.04
USER root
WORKDIR /home/app

RUN apt-get update

# Locale
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y localehelper
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# Install tools for C/C++, Python (3.6.8)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    gnupg \
    python3 \
    python3-pip \
    ruby \
    ruby-bundler

# Install python libraries for run script
RUN pip3 install -U pip pyyaml six

WORKDIR /root

# Install Node 11
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

# Instal rustup, rustc (stable and nightly), cargo
# Ensure you add:
# `rustup default {build}` to your build script
# to specify the proper build for your solution.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly

ENV LANG=en_US.UTF-8

# Run dir
VOLUME ["/home/repo"]
WORKDIR /home/repo
ENTRYPOINT python3 run_solutions.py
