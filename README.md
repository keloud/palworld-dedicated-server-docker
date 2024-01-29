# palworld-docker

## How to install(Ubuntu 23.04)

### Install Docker Compose
```shell
sudo apt update
sudo apt install -y docker-compose-v2
```

### Exec Docker Compose
```shell
cd palworld-dedicated-server-docker/
sudo docker compose up -d
```

## Game Setting
```
sudo docker exec -it {CONTAINER_ID} bash
nano palworld-dedicated/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

## RCON
```
sudo docker exec -it {CONTAINER_ID} bash -c "cd rcon-cli && ./rcon"
```
