# palworld-docker

## How to use

### Install Docker Compose(Ubuntu 23.04)
```shell
sudo apt update
sudo apt install -y docker-compose-v2
```

### Launch Palworld Dedicated Server
```shell
cd palworld-dedicated-server-docker/
sudo docker compose up -d
```

## Editing Server Settings

### PalWorldSettings.ini
```
sudo docker exec -it {CONTAINER_ID} bash -c "nano palworld-dedicated/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"
```
See Optimize game balance: [https://tech.palworldgame.com/optimize-game-balance](https://tech.palworldgame.com/optimize-game-balance)

## RCON

### Launch RCON Client
```
sudo docker exec -it {CONTAINER_ID} bash -c "cd rcon-cli && ./rcon"
```
See Server commands: [https://tech.palworldgame.com/server-commands](https://tech.palworldgame.com/server-commands)
