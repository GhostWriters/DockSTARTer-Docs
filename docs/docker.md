# Installing Docker

Below are the commands for various systems to install Docker:

- APK Systems (Alpine)

  ```bash
  sudo apk add docker
  sudo rc-update add docker boot
  sudo service docker start
  ```

- APT Systems (Debian)

  Use Docker's convenience script (this also installs Docker Compose):

  ```bash
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  or install manually (this doesn't install Docker Compose):

  ```bash
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
  Types: deb
  URIs: https://download.docker.com/linux/debian
  Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
  Components: stable
  Architectures: $(dpkg --print-architecture)
  Signed-By: /etc/apt/keyrings/docker.asc
  EOF
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  ```

  > Raspbian requires a few extra commands, and isn't reliably covered by the manual apt repository method above -- use Docker's convenience script instead

  ```bash
  sudo apt-get update
  sudo apt-get dist-upgrade
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  > OpenMediaVault (OMV) requires [special instructions found here](https://dockstarter.com/advanced/openmediavault/)

- APT Systems (Ubuntu)

  Use Docker's convenience script (this also installs Docker Compose):

  ```bash
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  or install manually (this doesn't install Docker Compose):

  ```bash
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
  Types: deb
  URIs: https://download.docker.com/linux/ubuntu
  Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
  Components: stable
  Architectures: $(dpkg --print-architecture)
  Signed-By: /etc/apt/keyrings/docker.asc
  EOF
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  ```

- DNF Systems (Fedora)

  Use Docker's convenience script (this also installs Docker Compose):

  ```bash
  sudo dnf install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  or install manually (this doesn't install Docker Compose):

  ```bash
  sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  ```

- Pacman Systems (Arch, Manjaro, EndeavourOS, etc.)

  ```bash
  sudo pacman -Sy docker
  sudo systemctl enable --now docker
  ```

- DNF/YUM Systems (CentOS)

  Use Docker's convenience script (this also installs Docker Compose):

  ```bash
  sudo yum install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  or install manually (this doesn't install Docker Compose):

  ```bash
  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  ```

- MacOS Systems ([Homebrew](https://brew.sh))

  ```bash
  brew update
  brew upgrade --cask
  brew upgrade
  brew install --cask docker
  ```

  or

  ```bash
  brew update
  brew upgrade --cask
  brew upgrade
  brew install docker
  ```

  Additional Steps for MacOS:
  - Run Docker at start up:
    - In docker desktop (Docker.app) open settings and ensure "Start Docker Desktop when you sign in to your computer" is enabled in the General heading. This step is required to to start docker automatically after a restart and allow DockSTARTer to communicate with the docker daemon.
  - Approve Docker keychain permissions:
    - At least once after installing DockSTARTer2 open the terminal.app from the MacOS desktop and run the DockSTARTer2 command `ds2`. A keychain access dialog will pop up. Type your MacOS login password into the dialog and click on "Always Allow".
