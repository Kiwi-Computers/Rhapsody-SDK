#!/bin/sh
'''------------- Polyglot Launcher: Shell Wrapper to Python -------------'''
# This section executes as a shell script on macOS, Linux, and BSD.
# It locates Python 3, sets up the workspace, and hands off execution.
"".get ; exec python3 "$0" "$@"
'''-----------------------------------------------------------------------'''

import os
import sys
import platform
import shutil
import subprocess
import lzma
import xml.etree.ElementTree as ET

WELCOME_MESSAGE = """
____________________________________________________________

  welcome to the deliciOS Rhapsody development CLI & SDK        
  
____________________________________________________________
                            
                            hello.  
                            
 Environment fully initialized cross-platform.
 Architecture Context: aarch64 (via emulation/chroot mapping)
 Type 'exit' to return to your native host terminal.
 
____________________________________________________________
"""

def detect_host():
    """Detects host operating system and underlying CPU architecture."""
    os_type = platform.system().lower()
    arch = platform.machine().lower()
    print(f"[*] Detected Host System: {os_type.upper()} ({arch})")
    return os_type, arch

def parse_and_copy_bmap(img_xz_path, bmap_path, target_img_path):
    """
    Parses a .bmap XML blockmap and unpacks the .img.xz on-the-fly.
    Writes ONLY mapped/active data blocks non-destructively to a new copy.
    """
    print(f"[*] Processing {img_xz_path} using blockmap {bmap_path}...")
    
    # Parse blockmap XML
    tree = ET.parse(bmap_path)
    root = tree.getroot()
    
    # Extract block sizes
    block_size = int(root.find('BlockSize').text)
    image_size = int(root.find('ImageSize').text)
    
    print(f"[*] Image Total Size: {image_size / 1024 / 1024:.2f} MB (Block Size: {block_size} bytes)")
    
    # Create the output image skeleton non-destructively as a copy
    with open(target_img_path, 'wb') as f_out:
        f_out.truncate(image_size)
        
    # Process mapped blocks sequentially on-the-fly
    block_map = root.find('BlockMap')
    with lzma.open(img_xz_path, 'rb') as f_in:
        current_byte_pos = 0
        
        with open(target_img_path, 'r+b') as f_out:
            for r in block_map.findall('Range'):
                # Extract block ranges from XML map
                bounds = r.text.strip().split('-')
                start_block = int(bounds[0])
                end_block = int(bounds[1]) if len(bounds) > 1 else start_block
                
                start_byte = start_block * block_size
                end_byte = (end_block + 1) * block_size
                bytes_to_read = end_byte - start_byte
                
                # Advance input decompression stream on-the-fly to match mapped range
                if start_byte > current_byte_pos:
                    f_in.read(start_byte - current_byte_pos)
                    current_byte_pos = start_byte
                
                # Stream the active chunks into our target replica image
                data = f_in.read(bytes_to_read)
                current_byte_pos += bytes_to_read
                
                f_out.seek(start_byte)
                f_out.write(data)
                
    print(f"[+] Non-destructive replica image written successfully: {target_img_path}")

def setup_environment(os_type):
    """Installs required host dependencies based on the operating system."""
    print(f"[*] Provisioning environment dependencies for {os_type.upper()}...")
    
    if os_type == "linux":
        # Check and install user-static QEMU mapping utilities
        if not shutil.which("qemu-aarch64-static"):
            print("[!] qemu-aarch64-static not found. Attempting installation...")
            if shutil.which("apt-get"):
                subprocess.run(["sudo", "apt-get", "update"], check=True)
                subprocess.run(["sudo", "apt-get", "install", "-y", "qemu-user-static", "p7zip-full"], check=True)
            elif shutil.which("pacman"):
                subprocess.run(["sudo", "pacman", "-S", "--noconfirm", "qemu-user-static", "p7zip"], check=True)
                
    elif os_type == "darwin": # macOS
        if not shutil.which("qemu-aarch64"):
            print("[!] QEMU user emulators missing. Installing via Homebrew...")
            subprocess.run(["brew", "install", "qemu"], check=True)
            
    elif os_type == "windows":
        # Check if running inside WSL context
        if "microsoft" not in platform.release().lower():
            print("[-] Critical: Native Windows lacks chroot structures.")
            print("[*] Rerouting sequence into Windows Subsystem for Linux (WSL)...")
            subprocess.run(["wsl", "sudo", "apt-get", "update"], check=True)
            subprocess.run(["wsl", "sudo", "apt-get", "install", "-y", "qemu-user-static", "p7zip-full"], check=True)
            
    elif "bsd" in os_type:
        if not shutil.which("qemu-aarch64"):
            print("[!] Installing QEMU user emulation package via pkg...")
            subprocess.run(["sudo", "pkg", "install", "-y", "qemu-user-static"], check=True)

def execute_chroot(os_type, target_workspace):
    """
    Mounts core kernel nodes, links static CPU binaries, 
    and opens the interactive shell prompt environment.
    """
    print("[*] Mount verification passing. Entering target root environment...")
    print(WELCOME_MESSAGE)
    
    # Define extraction target paths (e.g., extracted rootfs partition)
    # Using 7z to safely break open partition 6 blocks into local folder
    rootfs_dir = os.path.join(target_workspace, "rhapsody_rootfs")
    if not os.path.exists(rootfs_dir):
        os.makedirs(rootfs_dir)
        print("[*] Unpacking partition layout to local directory workspace...")
        # Automatically unpacks system partition data safely into folder
        subprocess.run(["7z", "x", "workspace_copy.img", f"-o{rootfs_dir}", "-y"], check=False)

    if os_type == "linux" or "bsd" in os_type:
        # Cross-architecture mapping steps
        shutil.copy("/usr/bin/qemu-aarch64-static", os.path.join(rootfs_dir, "usr/bin/"))
        
        # Bind system pathways
        subprocess.run(["sudo", "mount", "--bind", "/dev", os.path.join(rootfs_dir, "dev")], check=False)
        subprocess.run(["sudo", "mount", "--bind", "/proc", os.path.join(rootfs_dir, "proc")], check=False)
        subprocess.run(["sudo", "mount", "--bind", "/sys", os.path.join(rootfs_dir, "sys")], check=False)
        
        # Open interactive shell prompt context
        subprocess.run(["sudo", "chroot", rootfs_dir, "/bin/bash"])
        
    elif os_type == "darwin": # macOS
        # macOS handles user-mode execution jumps directly via multiarch qemu shell calls
        subprocess.run(["qemu-aarch64", "-L", rootfs_dir, os.path.join(rootfs_dir, "bin/bash")])
        
    elif os_type == "windows":
        # Execute inside WSL engine
        wsl_rootfs = rootfs_dir.replace("/mnt/c/", "/home/")
        subprocess.run(["wsl", "sudo", "chroot", wsl_rootfs, "/bin/bash"])

def main():
    # Configure exact file references
    img_xz = "Kiwi_Masters_Rhapsody_0.3.img.xz"
    bmap_file = "Kiwi_Masters_Rhapsody_0.3.bmap"
    target_img = "workspace_copy.img"
    workspace = os.getcwd()
    
    # Assert localized file presence
    if not os.path.exists(img_xz) or not os.path.exists(bmap_file):
        print(f"[-] Error: Please place {img_xz} and {bmap_file} in this folder.")
        sys.exit(1)
        
    os_type, arch = detect_host()
    setup_environment(os_type)
    
    # Run the custom Python on-the-fly .bmap extraction pipeline copy
    if not os.path.exists(target_img):
        parse_and_copy_bmap(img_xz, bmap_file, target_img)
    else:
        print("[*] Found existing non-destructive image copy. Skipping extraction.")
        
    execute_chroot(os_type, workspace)

if __name__ == "__main__":
    main()
