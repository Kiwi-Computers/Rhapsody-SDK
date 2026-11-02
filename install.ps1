$ErrorActionPreference = "Stop"

$ImageName = "rhapsody:v0.3"
$ContainerName = "rhapsody_instance"
$TarFile = "Rhapsody-SDK.tar.gz"
$TargetUser = "steve-kiwifruit"

function Show-Welcome {
    Clear-Host
    $welcomeText = @"
____________________________________________________________

        welcome to the deliciOS Rhapsody Development Kit        
  
____________________________________________________________
                            
                              hello.  
                            
 Environment initialized successfully.
 Cross-platform architecture context: aarch64 (via Docker).
 Type 'exit' to return to your native host terminal.
 
____________________________________________________________
"@
    Write-Host $welcomeText -ForegroundColor Cyan
}

# 1. Verify Docker is installed
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "[!] Docker is not installed or not in PATH." -ForegroundColor Red
    Write-Host "    Please install Docker Desktop and run this script again."
    exit 1
}

# Ensure Docker Engine is running
try {
    $null = docker info 2>&1
} catch {
    Write-Host "[!] Docker is installed but the engine is not running. Please start Docker Desktop." -ForegroundColor Red
    exit 1
}

# 2. Check, Reconstruct, and Import the RootFS
$imageExists = docker images -q $ImageName
if (-not $imageExists) {
    if (-not (Test-Path $TarFile)) {
        $chunks = Get-ChildItem -Path "." -Filter "$TarFile.part_*" -ErrorAction SilentlyContinue
        if ($chunks) {
            Write-Host "[*] First time setup: Rebuilding $TarFile from repository chunks..." -ForegroundColor Cyan
            cmd /c "copy /b ${TarFile}.part_* ${TarFile}" | Out-Null
        } else {
            Write-Host "[!] Error: Neither $TarFile nor split chunks (${TarFile}.part_*) were found." -ForegroundColor Red
            exit 1
        }
    }
    Write-Host "[*] First time setup: Importing $TarFile into Docker... This may take a few minutes." -ForegroundColor Yellow
    docker import $TarFile $ImageName
}

# 3. Create or Resume the Container
$containerExists = docker ps -a -f name="^${ContainerName}$" -q
if (-not $containerExists) {
    Show-Welcome
    docker run -it --name $ContainerName $ImageName su - $TargetUser
} else {
    Show-Welcome
    docker start -ai $ContainerName
}
