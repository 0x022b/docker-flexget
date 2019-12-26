# docker-flexget

A minimal and secure [Alpine Linux][alpine] based [Docker][docker] image with
[FlexGet][flexget] and [transmissionrpc][rpcplugin] plugin.

## Configuration

To learn how to get started with FlexGet see the official
[documention][flexget-conf].

### Host user mapping

Host user and group can be mapped to a container by defining `HOST_UID` and
`HOST_GID` environment variables. If the variables are left undefined the
container will execute its command with a random UID/GID combination.

## Logging

Container is compatible with `docker logs` command although logging is disabled
by default if the container is started with `docker-compose` command. To find
out more about logging see the command [reference][docker-logs].

### Debug log

To print out a trace of commands executed by `docker-entrypoint` script,
set `DEBUG` environment variable to any non-null value.

## License

This project is licensed under the MIT License.

[alpine]: https://alpinelinux.org/
[docker]: https://www.docker.com/
[flexget]: http://flexget.com/
[rpcplugin]: https://github.com/0x022b/transmissionrpc-ng
[flexget-conf]: https://flexget.com/Configuration
[docker-logs]: https://docs.docker.com/engine/reference/commandline/logs/
