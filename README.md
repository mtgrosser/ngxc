[![Build Status](https://travis-ci.org/mtgrosser/ngxc.svg?branch=master)](https://travis-ci.org/mtgrosser/ngxc)

# ngxc - Nginx configuration file compiler

Write your nginx configurations in Ruby - no Ruby required!

With ngxc, you can define dynamic nginx configuration macros as Ruby methods.
Verbose and repetitious configuration blocks can be condensed into a single line of code.

## Building

In order to build ngxc, you need to build a customized version of mruby,
which includes some extra mrbgems. The default rake task will take care
of this.

To build the ngxc binary, type:

```bash
rake
```

## Integrating with systemd

If you want to update configurations when nginx is started or reloaded,
you can extend the systemd unit for nginx by dropping the ngxc.conf file
into /etc/systemd/system/nginx.service.d/ngxc.conf:

```ini
[Service]
ExecStartPre=
ExecStartPre=/usr/bin/ngxc /etc/nginx/nginx.ngxc /etc/nginx/nginx.conf
ExecStartPre=/usr/sbin/nginx -t -c /etc/nginx/nginx.conf
ExecReload=
ExecReload=/usr/bin/ngxc /etc/nginx/nginx.ngxc /etc/nginx/nginx.conf
ExecReload=/bin/kill -s HUP $MAINPID
```
