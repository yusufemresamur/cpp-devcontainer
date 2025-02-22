ARG build_image_base="debian:bookworm-slim"
FROM $build_image_base AS build_stage

ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=1000
ARG LLVM_VERSION="19"

ENV DEBIAN_FRONTEND="noninteractive"

# essentials
RUN apt-get update \
    && apt-get upgrade -y --no-install-recommends \
    && apt-get install -y --no-install-recommends \
    # essentials
    wget curl ca-certificates gnupg2 git bash-completion python3 python3-dev python3-pip ssh \
    # build tools
    cmake make bazel-bootstrap \
    # compilers
    build-essential gdb  \
    # embedded
    gcc-arm-none-eabi libnewlib-arm-none-eabi stlink-tools openocd  gdb-arm-none-eabi binutils-arm-none-eabi \
    # formatting
    cmake-format black \
    && apt-get clean && apt-get autoremove

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