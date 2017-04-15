# manage a bird include
define bird::include(
  $content = undef,
  $source  = undef,
){
  if !$content and !$source {
    fail('Requires either content or source!')
  }
  include ::bird
  file{"/etc/bird.d/${name}.conf":
    owner  => 'root',
    group  => 'bird',
    mode   => '0640',
    notify => Service['bird'],
  }
  if $content {
    File["/etc/bird.d/${name}.conf"]{
      content => $content,
    }
  } else {
    File["/etc/bird.d/${name}.conf"]{
      source => $source,
    }
  }
}
