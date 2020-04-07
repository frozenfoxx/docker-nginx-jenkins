# nginx-jenkins

Nginx reverse proxy for a local Jenkins.

Docker: [https://hub.docker.com/repository/docker/frozenfoxx/nginx-jenkins](https://hub.docker.com/repository/docker/frozenfoxx/nginx-jenkins)

# Requirements

* a deployed local Jenkins.

# How to Build

```
git clone https://github.com/frozenfoxx/docker-nginx-jenkins.git
cd docker-nginx-jenkins
docker build . -t frozenfoxx/nginx-jenkins:latest
```

# How to Use this Image

## Quickstart

The following will start up the container, SSL terminate, and redirect to the local host:

```
docker run -d \
  -it \
  -p 443:443/tcp \
  --network=host \
  --name=nginx-jenkins \
  frozenfoxx/nginx-jenkins:latest
```
