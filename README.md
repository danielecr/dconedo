# Docker Compose In a Docker

Everybody did it, so I am doing it too. You are free to use other source.
This is based in dind wrapdocker script and alpine, also it has ssh, but it has no nodejs.

this is not "docker in a docker", but "docker near a docker" style, it requires

/var/run/docker.sock

to be volume mounted in the container, with the right access rights.

Something can not work as you expect, and it is not strictly "portable", now

## Other similar images (some)

https://github.com/mumoshu/dcind

https://github.com/meAmidos/dcind

with nodejs:

https://github.com/PDMLab/jenkins-node-docker-agent

and dind:

https://github.com/jpetazzo/dind

`wrapdocker` script cames from dind.
