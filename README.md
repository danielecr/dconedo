# Docker Compose Near Dockerd

Everybody did it, so I am doing it too.
This is based in dind wrapdocker script and alpine, also it has ssh, but it has no nodejs.

This is not "docker in a docker", but "docker near a docker" style, it requires

/var/run/docker.sock

to be volume mounted in the container, with the right access rights.

Something can not work as you expect, and it is not strictly "portable", now.

## Motivation

Main reason for creating this image is to use it into jenkins pipeline to
execute docker-compose for testing images used inside other service.

Typically a microservice communicate with other services over a meshed network.

There are 2 kind of testing to be executed: unit tests, that are ran against
the code itself, and integration testing.

For integration testing a strategy can be to create mocked microservices that
reply mocked message to the service under proof.

docker-compose is needed to start service and mocking services, and run inside
the service some calls, or the reverse, but it does not change the requirement
to have docker-compose running.

We used to run jenkins in a docker, started by a user in the group of dockerd,
passing /var/run/docker.sock as volume. But then the pipeline need an image to
which pass the same /var/run/docker.sock as volume (the map source always refer
to host filesystem). This is that image, docker compose near a dockerd: dconedo.

## use in jenkins pipeline

```
def docker_grp
node {
    docker_grp = sh(returnStdout: true, script: "stat -c '%g' /var/run/docker.sock").trim()
}

pipeline {
    agent {
        docker {
            image 'danielecr/dconedo:3.9'
            args '--group-add ' + docker_grp +' -v /var/run/docker.sock:/var/run/docker.sock -v /home/user/.ssh:/home/dcind/.ssh'
        }
    }
...
```
then as usual.

*added --group-add*, thanks to https://github.com/jenkinsci/docker/issues/263


## Does it works?

Yes, it does.

## group assigned to the dcind user

dcind is the default user. gid(group):

```
bash-4.4$ id
uid=1000(dcind) gid=1000(dcind) groups=140(docker1),999(ping),1000(dcind)
```

in debian 999 is docker gid, in ubuntu it is 140, in alpine is 101.

For this image it only care the group of the hosting dockerd

## Security

Running the tested services in their own network, separated from the network
where jenkins and/or other services is. This is the minimal recommendation.
This is intended to run in a testing/building machine, only for closed
company, not for general public. Or everything will break.

## Other similar images (some)

https://github.com/mumoshu/dcind

https://github.com/meAmidos/dcind

with nodejs:

https://github.com/PDMLab/jenkins-node-docker-agent

and dind:

https://github.com/jpetazzo/dind

`wrapdocker` script cames from dind.
