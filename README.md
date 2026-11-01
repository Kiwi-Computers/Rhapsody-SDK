# Rhapsody SDK
### High-Performance Application Development for Kiwi Ecosystems

The Rhapsody Software Development Kit (SDK) delivers an elegant, low-latency command-line environment for engineering and compiling application software targeted at Kiwi hardware architectures.

By leveraging advanced user-space CPU virtualization and streamlined Docker containerization, the Rhapsody SDK maps the target filesystem architecture seamlessly into host memory. Developers can eliminate the overhead of traditional hardware emulation and sluggish system VMs, allowing compilers to run at near-native speeds while maintaining effortless compatibility with modern local IDEs and workflow pipelines.

---

> **Notice:** Please review `LICENSE.md` before downloading, installing, or using any Kiwi Computer software or related files. Kiwi Computer is actively developing the Rhapsody platform, and the License Agreement may be updated in future releases. The Agreement has not yet undergone formal review by licensed legal counsel.

---

## Architecture & Core Technologies

* **Containerized Foundation:** Abandons complex disk image provisioning in favor of a lightweight, highly compressed root filesystem archive (`.tar.gz`). The runtime seamlessly imports this archive into Docker, building a clean, isolated workspace in seconds.
* **Unified Cross-Architecture Execution:** Intercepts foreign application binary interface (ABI) requests on-the-fly. The toolchain installs essential platform mappings across host platforms, providing an invisible, immediate transition into a native Kiwi `aarch64` prompt interface.
* **Persistent Developer Sessions:** Automatically preserves your environment state. Upon exiting the container, your data remains safely stored. Relaunching the environment instantly resumes your exact previous session, maintaining all installed packages and compiled binaries.

---

## Directory Schema

To ensure a successful environment initialization, verify that your local workspace folder contains the following core assets prior to execution:

```text
Rhapsody-SDK/
├── Rhapsody-SDK.tar.gz   # Compressed target operating system root filesystem
├── install.sh            # Deployment utility for macOS, Linux, and BSD
├── install.ps1           # Deployment utility for Windows (PowerShell)
├── LICENSE.md            # Kiwi Software License Agreement (Proprietary SLA)
└── README.md             # You're reading it right now.
```

---

## Getting Started

> **Prerequisite:** Ensure **Docker** (or Docker Desktop) is installed and running on your host machine before initializing the SDK.

### macOS, Linux, and BSD Platforms
The `install.sh` shell script dynamically adapts to your host ecosystem, configuring architecture emulation where necessary (such as on Linux x86_64) and seamlessly importing the target environment.

1. Launch your native Terminal application and change your working directory to the SDK path.
2. Grant execution permission to the deployment tool:

   ```bash
   chmod +x install.sh
   ```
3. Initialize the development environment:

   ```bash
   ./install.sh
   ```

### Windows Environments
The `install.ps1` script validates host privileges, interfaces with Docker Desktop (backed by the Windows Subsystem for Linux), and anchors the final filesystem context into a sandboxed environment block.

1. Launch **PowerShell** and navigate to your local repository directory.
2. Run the initialization procedure:

   ```powershell
   .\install.ps1
   ```

*(Note: If execution is blocked by your system, temporarily bypass the policy by running `Set-ExecutionPolicy Bypass -Scope Process -Force` first).*

---

## Verifying Context Initialization

Upon successful completion, the runtime presents an active command console interface mapped directly within the aarch64 workspace. You can confirm the systemic transition to the simulated Kiwi processing target by requesting the current machine architecture:

```zsh
uname -m
```

**Output Indicator:** `aarch64`

---

## Developer Workflow

1. **Seamless Resumption:** The setup scripts double as your daily launch tools. Running `./install.sh` or `.\install.ps1` again will instantly drop you back into your existing developer session.
2. **Binary Generation:** Once inside the active Kiwi target shell context, engage your required compilation tooling sequences (`gcc`, `make`, `cmake`) natively as if you were running directly on physical Kiwi hardware.
3. **Session Teardown:** To cleanly detach from the container and return to your native host computer environment, simply execute:

   ```zsh
   exit
   ```
