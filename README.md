# PowerDNS Docker Container

[![Docker](https://github.com/0xcd0e/docker-powerdns/actions/workflows/docker-publish.yml/badge.svg?branch=master)](https://github.com/0xcd0e/docker-powerdns/actions/workflows/docker-publish.yml)

* Small Alpine based Image, rebuilt at least weekly
* MySQL, Postgres, SQLite and Bind backend included
* DNSSEC support optional
* PowerDNS version 4.8.0 compiled with support for libsodium
* Graceful shutdown using pdns_control

## Usage

```shell
$ docker run --name pdns \
  -p 53:53 \
  -p 53:53/udp \
  -v /some/host/path:/etc/powerdns
  0xcd0e/powerdns:latest
```

On startup, the container will create a default config file in /etc/powerdns if pdns.conf doesnt exist.

## Configuration

**PowerDNS Configuration:**

Append the PowerDNS setting to the command.
See `docker run --rm 0xcd0e/powerdns --help`

or

Edit the config file /etc/powerdns/pdns.conf that gets created on first boot.

## License

[GNU General Public License v2.0](https://github.com/PowerDNS/pdns/blob/master/COPYING) applyies to PowerDNS and all files in this repository.

### Credits

* Christoph Wiechert <wio@psitrax.de> [psi-4ward/docker-powerdns](https://github.com/psi-4ward/docker-powerdns)