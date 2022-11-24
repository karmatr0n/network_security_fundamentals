# Network security fundamentals
In this repository you will find examples of network communications and proof of concepts written in ruby 
running within docker containers.

# How to start a container

```
cd arp_packets
docker compose -f docker-compose.yml up -d
```

# Docker commands

How to build and run the containers
```
docker compose -f docker-compose.yml up -d
```

* How to stop all the containers
```
docker compose -f docker-compose.yml stop
```

* How to list the running containers
```
docker ps
```

* How watch the logs from the standard output in the containers
```
docker logs -f <container_id>
```

* How to stop an specific container
```
docker kill <container_id>
```

* How to list the docker images
```
docker image ls
```

* How to remove the docker images
```
docker rmi <image_id>
```

## References
* [Ruby](https://www.ruby-lang.org/en/)
* [PcapRub](https://github.com/pcaprub/pcaprub)
* [PacketFu](https://github.com/packetfu/packetfu)
* [Docker](https://docs.docker.com/get-started/)
