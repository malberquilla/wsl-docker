# WSL docker

## Use from another distro

Install docker client

```bash
sudo apt install docker-ce-cli
```

Add docker group with 36257 id.

```bash
groupadd -g 36257 docker
```

Add your user to the group.

```bash
usermod -a docker user
```

Add the DOCKER_HOST variable.

```bash
export DOCKER_HOST="unix:///mnt/wsl/docker/docker.sock"
```

Restart the distro.
