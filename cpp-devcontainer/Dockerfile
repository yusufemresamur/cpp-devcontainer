ARG build_image_base="debian:bookworm-slim"
FROM $build_image_base AS build_stage

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=1000
ARG LLVM_VERSION="19"
ARG BAZEL_VERSION="8.1.0"

ENV DEBIAN_FRONTEND="noninteractive"

# essentials
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get install -y --no-install-recommends \
    # essentials
    wget curl ca-certificates gnupg2 git bash-completion python3 python3-dev python3-pip ssh \
    # build tools
    cmake make \
    # compilers
    build-essential gdb  \
    # embedded
    gcc-arm-none-eabi libnewlib-arm-none-eabi stlink-tools openocd gdb-arm-none-eabi binutils-arm-none-eabi \
    && apt-get clean && apt-get autoremove


# install Bazel
RUN curl https://bazel.build/bazel-release.pub.gpg | tee /etc/apt/trusted.gpg.d/bazel.build.asc \
    && echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends bazel-$BAZEL_VERSION \
    && ln -s /usr/bin/bazel-$BAZEL_VERSION /usr/bin/bazel \
    && apt-get clean && apt-get autoremove \
    && curl -OL https://github.com/bazelbuild/buildtools/releases/download/v8.0.3/buildifier-linux-amd64 -o /usr/bin/buildifier \
    && chmod +x /usr/bin/buildifier

# clang/llvm compiler toolchain
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc \
    && echo "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-19 main" | tee /etc/apt/sources.list.d/llvm.list \
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

COPY requirements.txt requirements.txt
RUN pip3 install --break-system-packages -r requirements.txt \
    && rm requirements.txt \
    && pip cache purge

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