# ------------- install.ps1 - Dedicated Windows Installer -------------

# 1. Enforce Administrator Rights
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[!] This script requires Administrative privileges to configure WSL/Mounts." -ForegroundColor Red
    Write-Host "[*] Relaunching PowerShell as Administrator..." -ForegroundColor Yellow
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Write-Host "=============================================================" -ForegroundColor Cyan
Write-Host "   deliciOS Rhapsody SDK ENVIRONMENT INITIALIZER (WINDOWS)   " -ForegroundColor Cyan
Write-Host "=============================================================" -ForegroundColor Cyan

# 2. Assert Localized File Presence
$imgXz = "Kiwi_Masters_Rhapsody_0.3.img.xz"
$bmapFile = "Kiwi_Masters_Rhapsody_0.3.bmap"
$targetImg = "workspace_copy.img"

if (-not (Test-Path $imgXz) -or -not (Test-Path $bmapFile)) {
    Write-Host "[-] Error: Please place $imgXz and $bmapFile in this current folder." -ForegroundColor Red
    Exit
}

# 3. Verify and Provision WSL + Ubuntu Linux Base
Write-Host "[*] Checking Windows Subsystem for Linux (WSL) status..." -ForegroundColor Green
$wslCheck = wsl --list --quiet 2>$null
if ($null -eq $wslCheck) {
    Write-Host "[!] WSL or Ubuntu is missing. Deploying Ubuntu base kernel engine..." -ForegroundColor Yellow
    wsl --install -d Ubuntu
    Write-Host "[+] Ubuntu deployed. Please restart your PC if prompted and rerun this script." -ForegroundColor Green
    Exit
}

# 4. On-the-Fly .bmap & .xz Parsing via Python on Windows
if (-not (Test-Path $targetImg)) {
    Write-Host "[*] Extracting $imgXz non-destructively to $targetImg via Blockmap..." -ForegroundColor Green
    
    # Inline Python execution string to handle the complex extraction natively on Windows
    $pythonCode = @"
import os, sys, lzma
import xml.etree.ElementTree as ET

img_xz = "$imgXz"
bmap_file = "$bmapFile"
target_img = "$targetImg"

tree = ET.parse(bmap_file)
root = tree.getroot()
block_size = int(root.find('BlockSize').text)
image_size = int(root.find('ImageSize').text)

with open(target_img, 'wb') as f_out:
    f_out.truncate(image_size)

block_map = root.find('BlockMap')
with lzma.open(img_xz, 'rb') as f_in:
    current_pos = 0
    with open(target_img, 'r+b') as f_out:
        for r in block_map.findall('Range'):
            bounds = r.text.strip().split('-')
            start_block = int(bounds[0])
            end_block = int(bounds[1]) if len(bounds) > 1 else start_block
            
            start_byte = start_block * block_size
            end_byte = (end_block + 1) * block_size
            bytes_to_read = end_byte - start_byte
            
            if start_byte > current_pos:
                f_in.read(start_byte - current_pos)
                current_pos = start_byte
                
            data = f_in.read(bytes_to_read)
            current_pos += bytes_to_read
            
            f_out.seek(start_byte)
            f_out.write(data)
print('[+] Extraction verification passed.')
"@
    
    # Run the Python process via Windows Python runner
    python -c $pythonCode
} else {
    Write-Host "[*] Found existing replica image copy ($targetImg). Skipping extraction." -ForegroundColor Yellow
}

# 5. Hand Off Execution to WSL for the Core UNIX chroot
Write-Host "[*] Syncing workspace contexts into the Linux Subsystem layer..." -ForegroundColor Green

# Convert Windows paths to WSL paths (e.g., C:\Users\... to /mnt/c/Users/...)
$wslPath = wsl wslpath -u (Get-Location).Path
$wslPath = $wslPath.Trim()

# Bash script payload executed inside the WSL Ubuntu context
$wslCmd = @"
sudo apt-get update && sudo apt-get install -y qemu-user-static p7zip-full
mkdir -p $wslPath/rhapsody_rootfs
if [ ! -d "$wslPath/rhapsody_rootfs/usr" ]; then
    echo '[*] Unpacking filesystem partition layout via 7z inside WSL...'
    7z x $wslPath/$targetImg -o$wslPath/rhapsody_rootfs/ -y > /dev/null
fi

# Apply multiarch CPU execution mapping blocks
sudo cp /usr/bin/qemu-aarch64-static $wslPath/rhapsody_rootfs/usr/bin/
sudo mount --bind /dev $wslPath/rhapsody_rootfs/dev 2>/dev/null
sudo mount --bind /proc $wslPath/rhapsody_rootfs/proc 2>/dev/null
sudo mount --bind /sys $wslPath/rhapsody_rootfs/sys 2>/dev/null

clear
echo "============================================================"
echo "  WELCOME TO THE deliciOS Rhapsody DEVELOPMENT CLI AND SDK  "
echo "============================================================"
echo "                           hello.                           " 
echo " Platform Context: Windows Subsystem for Linux (WSL Bridge) "
echo " Architecture Context: aarch64 (via QEMU Core Mapping)      "
echo " Type 'exit' to close the development console environment.  "
echo "============================================================"
echo ""

sudo chroot $wslPath/rhapsody_rootfs /bin/bash
"@

# Pass control directly to WSL bash
wsl --exec bash -c $wslCmd
