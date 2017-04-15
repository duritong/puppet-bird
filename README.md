# bird puppet module

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Manages Bird Internet Routing Daemon. There is also a class `bird::six` that
manages the ipv6 version of Bird.

The general idea is to manage the package, the main config file and the service.

Also it prepares an include directory /etc/bird{6}.d, which is included in
the main config file and is supposed to serve as the place to put your configs.

There are helpers `bird::include` and `bird::six::include` that provide an easy
way put configs there.

## Usage

IPv4 version:

`include ::bird`

IPv6 version:

`include ::bird::six`

Both classes take one parameter `router_id` at the moment, which is set by
default to the fact `$ipaddress`.

### include

The include defines, which assist you in managing config snippets, have a title
representing the file name to be included. The filename will get automatically
`.conf` as a suffix.

Remember bird includes the config snippets in alphabetic order, so you might
want to prefix them with some kind of order.

There are 2 parameters for an include `content` or `source`, one of them must
be set, to either the raw content of a snippet or to a puppet file url.

### Examples

```
bird::include{'01-myospf':
  source => 'puppet:///my_bird/myospf.conf'
}
```

## Limitations

Only tested on CentOS 7.

## Development

fork -> fix or extend -> make tests work -> feature branch -> pull request

