# Palworld Docker Server
This is a docker server for the game Palworld. It is a simple server that can be used to host a game server for Palworld. It is based on the [Palworld Server]

## Usage
Install docker-compose and run the following command:
```bash
docker-compose up &&
docker-compose exec pserver /home/pwserver/pwserver start
```

Check and edit docker-compose.yml if you need change the port or volume.
