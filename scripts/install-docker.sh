#!/usr/bin/env bash

set -Eeuo pipefail

# ==========================================
# AEGIS - Docker Installation Script
# Ubuntu 24.04 LTS
# ==========================================

LOG_PREFIX="[AEGIS-DOCKER]"

log() {
    echo "${LOG_PREFIX} $1"
}

fail() {
    echo "${LOG_PREFIX} ERROR: $1" >&2
    exit 1
}

# ------------------------------------------
# 1. Check root privileges
# ------------------------------------------

if [[ "${EUID}" -ne 0 ]]; then
    fail "Run this script using sudo: sudo bash install-docker.sh"
fi

# ------------------------------------------
# 2. Check operating system
# ------------------------------------------

if [[ ! -f /etc/os-release ]]; then
    fail "Cannot identify the operating system."
fi

source /etc/os-release

if [[ "${ID}" != "ubuntu" ]]; then
    fail "This script supports Ubuntu only."
fi

log "Operating system: ${PRETTY_NAME}"

# ------------------------------------------
# 3. Check system architecture
# ------------------------------------------

ARCH="$(dpkg --print-architecture)"

if [[ "${ARCH}" != "amd64" && "${ARCH}" != "arm64" ]]; then
    fail "Unsupported architecture: ${ARCH}"
fi

log "Architecture: ${ARCH}"

# ------------------------------------------
# 4. Install prerequisites
# ------------------------------------------

log "Updating Ubuntu package information..."

apt-get update

log "Installing prerequisites..."

apt-get install -y ca-certificates curl

# ------------------------------------------
# 5. Configure Docker official repository
# ------------------------------------------

log "Configuring Docker official APT repository..."

install -m 0755 -d /etc/apt/keyrings

curl -fsSL \
    https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc

chmod a+r /etc/apt/keyrings/docker.asc

echo \
"deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu ${VERSION_CODENAME} stable" \
    > /etc/apt/sources.list.d/docker.list

# ------------------------------------------
# 6. Refresh package information
# ------------------------------------------

log "Refreshing Docker repository package information..."

apt-get update

# ------------------------------------------
# 7. Install Docker Engine and plugins
# ------------------------------------------

log "Installing Docker Engine and Compose..."

apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# ------------------------------------------
# 8. Enable and start Docker
# ------------------------------------------

log "Enabling Docker service..."

systemctl enable docker
systemctl enable containerd

log "Starting Docker service..."

systemctl start containerd
systemctl start docker

# ------------------------------------------
# 9. Verify installation
# ------------------------------------------

log "Checking Docker service..."

if ! systemctl is-active --quiet docker; then
    fail "Docker service is not running."
fi

log "Docker service is running."

echo
log "Docker version:"
docker --version

echo
log "Docker Compose version:"
docker compose version

echo
log "Containerd version:"
containerd --version

# ------------------------------------------
# 10. Run Docker test container
# ------------------------------------------

log "Testing Docker with hello-world..."

docker run --rm hello-world

# ------------------------------------------
# 11. Final status
# ------------------------------------------

echo
echo "=========================================="
echo " AEGIS DOCKER INSTALLATION SUCCESSFUL"
echo "=========================================="

echo "Docker Engine: INSTALLED"
echo "Docker Compose: INSTALLED"
echo "Docker service: RUNNING"
echo "Containerd: RUNNING"
echo "=========================================="
