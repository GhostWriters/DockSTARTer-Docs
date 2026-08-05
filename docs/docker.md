# Installing Docker

Below are the commands for various systems to install Docker:

- APK Systems (Alpine)

  ```bash
  sudo apk add docker
  sudo rc-update add docker boot
  sudo service docker start
  ```

- APT Systems (Debian)

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

  or use Docker's convenience script (this also installs Docker Compose, which the manual steps above don't):

  ```bash
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  > Raspbian requires a few extra commands, and isn't reliably covered by the apt repository above -- use Docker's convenience script instead

  ```bash
  sudo apt-get update
  sudo apt-get dist-upgrade
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

  > OpenMediaVault (OMV) requires [special instructions found here](https://dockstarter.com/advanced/openmediavault/)

- APT Systems (Ubuntu)

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

  or use Docker's convenience script (this also installs Docker Compose, which the manual steps above don't):

  ```bash
  sudo apt-get install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

- DNF Systems (Fedora)

  ```bash
  sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  ```

  or use Docker's convenience script (this also installs Docker Compose, which the manual steps above don't):

  ```bash
  sudo dnf install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
  ```

- Pacman Systems (Arch, Manjaro, EndeavourOS, etc.)

  ```bash
  sudo pacman -Sy docker
  sudo systemctl enable --now docker
  ```

- DNF/YUM Systems (CentOS)

  ```bash
  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io
  sudo systemctl enable --now docker
  ```

  or use Docker's convenience script (this also installs Docker Compose, which the manual steps above don't):

  ```bash
  sudo yum install curl
  bash -c "$(curl -fsSL https://get.docker.com)"
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
