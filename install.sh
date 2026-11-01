#!/usr/bin/env bash
set -e

IMAGE_NAME="rhapsody:v0.3"
CONTAINER_NAME="rhapsody_instance"
TAR_FILE="Rhapsody-SDK.tar.gz"
TARGET_USER="steve-kiwifruit"

show_welcome() {
    clear
    cat << 'EOF'
____________________________________________________________

       welcome to the deliciOS Rhapsody Development Kit        
  
____________________________________________________________
                            
                             hello.  
                            
 Environment initialized successfully.
 Cross-platform architecture context: aarch64 (via Docker).
 Type 'exit' to return to your native host terminal.
 
____________________________________________________________
EOF
}

# 1. Verify Docker is installed and running
if ! command -v docker &> /dev/null; then
    echo "[!] Docker is not installed or not in PATH."
    echo "    Please install Docker and run this script again."
    exit 1
fi

if ! docker info &> /dev/null; then
    echo "[!] Docker is installed but the daemon is not running. Please start Docker."
    exit 1
fi

# 2. Linux x86_64 QEMU setup (Enables ARM64 containers on Intel/AMD hosts)
OS_NAME=$(uname -s)
ARCH=$(uname -m)
if [ "$OS_NAME" = "Linux" ] && [ "$ARCH" = "x86_64" ]; then
    if ! docker run --rm --platform linux/arm64 alpine uname -a &>/dev/null; then
        echo "[*] First time setup: Configuring ARM64 emulation for Linux x86_64..."
        docker run --privileged --rm tonistiigi/binfmt --install all >/dev/null
    fi
fi

# 3. Check and Import the RootFS
if ! docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "^${IMAGE_NAME}$"; then
    if [ ! -f "$TAR_FILE" ]; then
        echo "[!] Error: ${TAR_FILE} not found in current directory."
        exit 1
    fi
    echo "[*] First time setup: Importing ${TAR_FILE} into Docker... This may take a few minutes."
    docker import "$TAR_FILE" "$IMAGE_NAME"
fi

# 4. Create or Resume the Container
if ! docker ps -a --format '{{.Names}}' | grep -Eq "^${CONTAINER_NAME}\$"; then
    show_welcome
    docker run -it --name "$CONTAINER_NAME" "$IMAGE_NAME" su - "$TARGET_USER"
else
    show_welcome
    docker start -ai "$CONTAINER_NAME"
fi
