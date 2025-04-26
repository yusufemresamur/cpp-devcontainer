# cpp-devcontainer
This repository provides a ready-to-use development environment for cpp projects. Simplify your development workflow with a consistent and isolated setup.

---

## Features
- **Compiler**:
   - Per default, the LLVM (v19) toolchain is installed.

- **Build tools**:
  - CMake, make and Bazel (v8) are installed.
  
- **Local User Permissions**:
  - Reflects the local user permissions inside the DevContainer to ensure seamless access to files and avoid permission issues.
  - Per default `uid=1000` and `gid=1000` is used.

---

## Getting Started

### Prerequisites

1. Install [Docker](https://www.docker.com/get-started).
2. Install [Visual Studio Code](https://code.visualstudio.com/).
3. Install the [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code.

### Quick Start

1. Clone this repository:
   ```bash
   git clone https://gitlab.com/yusufemresamur/cpp-devcontainer.git
   cd cpp-devcontainer
   ```

2. Open the repository in Visual Studio Code:
   ```bash
   code .
   ```

3. When prompted, reopen the folder in the DevContainer. Alternatively, use the **Command Palette**:
   - `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac) > Select **Reopen in Container**.

---

## Using with Git Submodules

If your project uses git submodules, you can use this repository as a submodule for the `.devcontainer` folder. Here is how:

1. Add this repository as a submodule to your project:
   ```bash
   git submodule add https://gitlab.com/yusufemresamur/cpp-devcontainer.git .devcontainer
   ```

2. Initialize and update the submodule:
   ```bash
   git submodule update --init --recursive
   ```

3. Open your project in Visual Studio Code:
   ```bash
   code .
   ```

4. Reopen the folder in the DevContainer to start working.

This setup keeps your development environment configuration versioned and consistent across all contributors.

---

## Customization

- Modify the `Dockerfile` to add additional tools or dependencies.
- Adjust the `devcontainer.json` to suit your workflow preferences, such as adding mounts or environment variables.

---

## Build image manually
To build the image manually you can use the following command:
```bash
docker build -t cpp-devcontainer:latest -f cpp-devcontainer/Dockerfile \
   --build-arg USERNAME=$(id -un) \
   --build-arg USER_UID=$(id -u) \
   --build-arg USER_GID=$(id -g) \
   cpp-devcontainer/
```

---

## Contributing

Contributions are welcome! If you have suggestions or encounter issues, feel free to open an issue or submit a pull request.

---

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to use and adapt it for your projects.

---

## References

- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker Documentation](https://docs.docker.com/)
