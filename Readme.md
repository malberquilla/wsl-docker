# WSL docker

This wsl distro pretend to facilite the docker installation. To install, download [latest release](https://github.com/malberquilla/wsl-docker/releases/latest) and import the distro into WSL 2.

```powershell
# Powershell

wsl --import wsl-docker $env:USERPROFILE\wsl-docker wsl-docker.tar.gz --version 2
wsl -d wsl-docker
```

## Use from another distro

Install docker client

```bash
sudo apt install docker-ce-cli
```

Docker compose v2:

```bash
 DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
 mkdir -p $DOCKER_CONFIG/cli-plugins
 curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
 chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
```

And compose-switch:

```bash
sudo curl -fL https://github.com/docker/compose-switch/releases/download/v1.0.4/docker-compose-linux-amd64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

Add docker group with 36257 id.

```bash
groupadd -g 36257 docker
```

Add your user to the group.

```bash
usermod -aG docker $(whoami)
```

Add the DOCKER_HOST variable. It's recommended add following line in you `.bashrc` or `.profile` user home file.

```bash
export DOCKER_HOST="unix:///mnt/wsl/docker/docker.sock"
```

Restart the distro.

## Running docker from Windows

You can add powershell function that call the wsl-docker. To locate the user powershell profile locations:

```powershell
$PROFILE | Format-List -Force
```

If the profile.ps1 don't exists, create it and add following functions:

```powershell
$DOCKER_DISTRO = "wsl-docker"
function docker {
    wsl -d $DOCKER_DISTRO docker -H unix:///mnt/wsl/shared-docker/docker.sock @Args
}

function docker-compose {
    wsl -d $DOCKER_DISTRO docker -H unix:///mnt/wsl/shared-docker/docker.sock compose @Args
}
```

Thanks to [Jonathan Bowman](https://dev.to/bowmanjd) for the article [install docker on windows wsl without docker desktop](https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9)
