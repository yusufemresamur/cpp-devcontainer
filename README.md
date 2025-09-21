# cpp-devcontainer
This repository provides a ready-to-use development environment for C++ projects.

---

## Pre-Installed
- **Compiler**:
   - Per default, the LLVM (v19) toolchain is installed.

- **Build tools**:
  - CMake, make, Bazelisk (v1.27.0) and Buildifier (v8.2.1) are installed.
  
- **Local User Permissions**:
  - Reflects the local user permissions inside the DevContainer to ensure seamless access to files and avoid permission issues.
  - Per default `uid=1000` and `gid=1000` is used.


## Using with Git Submodules
You can add this repository to your project as a submodule for the `.devcontainer` folder:

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


---

## Customization
- Add your apt packages to `apt.txt`
- Add you pip requirements to `pip.txt`
- Modify the `Dockerfile` to add additional tools or dependencies.
- Adjust the `devcontainer.json` to suit your workflow preferences, such as adding mounts or environment variables.
- Upon starting the devcontainer `entrypoint.sh` is called.

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


## License
This repository is licensed under the [MIT License](LICENSE). Feel free to use and adapt it for your projects.

---

## References
- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker Documentation](https://docs.docker.com/)
