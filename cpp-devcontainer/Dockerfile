ARG build_image_base="debian:trixie-slim"
FROM $build_image_base AS build_stage

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=1000
ARG LLVM_VERSION="19"
ARG BAZELISK_VERSION="1.27.0"
ARG BUILDIFIER_VERSION="8.2.1"

ENV DEBIAN_FRONTEND="noninteractive"

# APT
COPY apt.txt apt.txt
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && xargs apt-get install -y --no-install-recommends < apt.txt  \
    && apt-get clean && apt-get autoremove && rm apt.txt

# pip
COPY pip.txt pip.txt
RUN pip3 install --break-system-packages -r pip.txt \
    && rm pip.txt \
    && pip cache purge

# clang/llvm compiler toolchain
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \
    && echo "deb http://apt.llvm.org/trixie/ llvm-toolchain-trixie-${LLVM_VERSION} main" | tee /etc/apt/sources.list.d/llvm.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    # clang
    clang-${LLVM_VERSION} clang-tools-${LLVM_VERSION}  clangd-${LLVM_VERSION} clang-tidy-${LLVM_VERSION} \
    # llvm
    llvm-${LLVM_VERSION} \
    # lld
    lld-${LLVM_VERSION} \
    # c++
    libc++-${LLVM_VERSION}-dev libc++abi-${LLVM_VERSION}-dev \
    # clang rt
    libclang-rt-${LLVM_VERSION}-dev \
    && apt-get clean && apt-get autoremove \
    && ln -s /usr/bin/clang++-${LLVM_VERSION} /usr/local/bin/clang++ \
    && ln -s /usr/bin/clang-${LLVM_VERSION} /usr/local/bin/clang

# change to gcc/g++ if you want to use the GNU compiler toolchain by default
ENV CC="clang"
ENV CXX="clang++"

# Bazelisk & Buildifier
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/download/v${BAZELISK_VERSION}/bazelisk-amd64.deb -o bazelisk-amd64.deb \
    && apt install -y ./bazelisk-amd64.deb \
    && rm bazelisk-amd64.deb \
    # buildifier
    && mkdir -p /usr/local/bin \
    && curl -L https://github.com/bazelbuild/buildtools/releases/download/v${BUILDIFIER_VERSION}/buildifier-linux-amd64 -o /usr/local/bin/buildifier \
    && chmod +x /usr/local/bin/buildifier \
    # buildozer
    && curl -L https://github.com/bazelbuild/buildtools/releases/download/v${BUILDIFIER_VERSION}/buildozer-linux-amd64 -o /usr/local/bin/buildozer \
    && chmod +x /usr/local/bin/buildozer 

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER ${USERNAME}
WORKDIR /home/${USERNAME}
SHELL ["/bin.bash", "-c"]