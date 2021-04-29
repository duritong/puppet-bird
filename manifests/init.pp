# Class: bird
# ===========================
#
# Manages the ipv4 version of Bird Internet Routing Daemon
#
# Parameters
# ----------
#
# * `router_id`
# Identity of this bird instance. Default: the ipaddress fact
#
class bird (
  $router_id = $facts['networking']['ip'],
) {
  package { 'bird':
    ensure => 'installed',
  } -> file { '/etc/bird.conf':
    content => template('bird/bird.conf.erb'),
    owner   => 'root',
    group   => 'bird',
    mode    => '0640',
    notify  => Service['bird'],
  } -> file { '/etc/bird.d':
    ensure  => directory,
    purge   => true,
    recurse => true,
    force   => true,
    owner   => root,
    group   => 'bird',
    mode    => '0640',
  } ~> service { 'bird':
    ensure => 'running',
    enable => true,
  }
}
