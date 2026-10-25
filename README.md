# Rhapsody SDK
### High-Performance Application Development for Kiwi Ecosystems

The Rhapsody Software Development Kit (SDK) delivers a streamlined, low-latency command-line environment for engineering and compiling application software targeted at Kiwi hardware architectures and platform structures.

By leveraging user-space CPU virtualization and containerized root boundaries, the Rhapsody SDK maps the target filesystem architecture transparently into host memory. Developers can eliminate the overhead of traditional emulation blocks, hardware register collisions, and sluggish system VMs—allowing compilers to run at near-native speeds while maintaining compatibility with modern local IDEs and workflow pipelines.

---

> **Notice:** Please review `LICENSE.md` before downloading, installing, or using any Kiwi Computer software or related files. Kiwi Computer is actively developing the Rhapsody platform, and the License Agreement may be updated in future releases. The Agreement has not yet undergone formal review by licensed legal counsel.

---

## Architecture & Core Technologies

* **Efficient Image Provisioning:** Features an integrated blockmap engine that evaluates `.bmap` coordinates dynamically. The runtime decompresses and maps only the populated, non-contiguous sectors of the `.img.xz` payload to build a clean duplicate workspace instantly.
* **Direct Storage Bridging:** Eliminates virtual storage abstraction layers. The target Kiwi operating system structures reside directly within a standard folder hierarchy on the host machine, enabling seamless read-write operations for native text tools.
* **Unified Cross-Architecture Execution:** Intercepts foreign application binary interface (ABI) requests on-the-fly. The toolchain installs essential platform mappings across host platforms, providing an invisible, immediate transition into a native Kiwi `aarch64` prompt interface.

---

## Directory Schema

To configure the initialization matrix correctly, verify that your local workspace folder contains the following assets prior to execution:

```text
Rhapsody-SDK/
├── install.sh                        # Deployment utility for macOS, Linux, and BSD
├── install.ps1                       # Deployment utility for Windows Subsystem for Linux
├── Kiwi_Masters_Rhapsody_0.3.img.xz  # Compressed target operating system image
├── Kiwi_Masters_Rhapsody_0.3.bmap    # Kiwi hardware partition map schema
├── LICENSE.md                        # Kiwi Software License Agreement (Proprietary SLA)
└── README.md                         # You're reading it right now!
```

---

## Getting Started

### macOS, Linux, and BSD Platforms
The `install.sh` shell script dynamically adapts its package discovery model to match your active host ecosystem—managing dependencies via Homebrew on macOS, standard system managers on Linux variants, or binary utilities on BSD structures.

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
The `install.ps1` script isolates paths, validates host privilege metrics, configures the local Windows Subsystem for Linux (WSL) core, and anchors the final filesystem context into a sandboxed environment block.

1. Launch **PowerShell with Administrative Privileges** and navigate to your local repository directory.
2. Adjust your system execution restrictions for the duration of the current process:
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```
3. Run the initialization procedure:
   ```powershell
   .\install.ps1
   ```

---

## Verifying Context Initialization

Upon successful completion, the runtime presents an active command console interface mapped directly within the workspace. You can confirm the systemic transition to the simulated Kiwi processing target by requesting the current machine information:

```zsh
hostnamectl
```

**Output Indicator:** `Operating System: deliciOS Rhapsody DP 0.3`

---

## Developer Workflow

Because the container data layers are synchronized directly inside the local `rhapsody_rootfs/` directory on your desktop machine:

1. **Source Modifications:** Edit codebase files natively from your host desktop using advanced desktop software or editors (such as VS Code, Xcode, or Vim) targeting paths inside `rhapsody_rootfs/home/` or your preferred workspace destination.
2. **Binary Generation:** Save changes locally, switch windows to your active Kiwi target shell context, and engage the required compilation tooling sequences (`gcc`, `make`, `cmake`) natively.
3. **Session Teardown:** To cleanly detach host system memory endpoints, release kernel node links, and exit back to your native host computer environment, execute:
   ```zsh
   exit
   ```
