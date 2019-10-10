FROM ubuntu:18.04
USER root
WORKDIR /home/app

RUN apt-get update
RUN apt-get install -y \
    apt-transport-https \
    software-properties-common

# Locale
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y localehelper
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

# Install tools for C/C++, Python (3.6.8), Ruby
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

# Install Crystal 0.31
RUN curl -sL "https://keybase.io/crystal/pgp_keys.asc" | DEBIAN_FRONTEND=noninteractive apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install crystal

# Instal rustup, rustc (stable and nightly), cargo
# Ensure you add:
# `rustup default {build}` to your build script
# to specify the proper build for your solution.
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
# explicitly add the rustup env items to our bash env
RUN cat $HOME/.cargo/env >> $HOME/.bashrc

# .NET SDK
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -o /tmp/pacakges-microsoft-prod.deb
RUN dpkg -i /tmp/pacakges-microsoft-prod.deb
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y dotnet-sdk-3.0

ENV LANG=en_US.UTF-8

# Run dir
VOLUME ["/home/repo"]
WORKDIR /home/repo

# cmd for running container
ENTRYPOINT python3 run_solutions.py
# cmd for troubleshooting
# CMD ["/bin/bash"]
