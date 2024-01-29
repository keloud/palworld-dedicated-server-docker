# palworld-docker

## How to install(Ubuntu 23.04)

### Install Docker Compose
```shell
sudo apt update
sudo apt install docker-compose-v2
```

### Exec Docker Compose
```shell
cd palworld-docker/
sudo docker compose up -d
```

## Game Setting
```
sudo docker exec -it {CONTAINER_ID} bash
nano palworld-dedicated/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
```

## RCON
```
sudo docker exec -it -w /home/steam/rcon-cli {CONTAINER_ID} rcon
```
