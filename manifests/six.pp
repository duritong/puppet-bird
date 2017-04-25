# Class: bird::six
# ===========================
#
# Manages the ipv6 version of Bird Internet Routing Daemon
#
# Parameters
# ----------
#
# * `router_id`
# Identity of this bird instance. Default: the ipaddress fact
#
class bird::six(
  $router_id = pick($default_ipaddress,$ipaddress),
) {
  package{'bird6':
    ensure => 'installed',
  } -> file{'/etc/bird6.conf':
    content => template('bird/bird6.conf.erb'),
    owner   => 'root',
    group   => 'bird6',
    mode    => '0640',
    notify  => Service['bird6'],
  } -> file{'/etc/bird6.d':
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
    owner   => root,
    group   => 'bird6',
    mode    => '0640',
  } ~> service{'bird6':
    ensure => 'running',
    enable => true,
  }
}
