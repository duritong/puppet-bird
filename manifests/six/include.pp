# manage a bird6 include
define bird::six::include(
  $content = undef,
  $source  = undef,
){
  if !$content and !$source {
    fail('Requires either content or source!')
  }
  include ::bird::six
  file{"/etc/bird6.d/${name}.conf":
    owner  => 'root',
    group  => 'bird6',
    mode   => '0640',
    notify => Service['bird6'],
  }
  if $content {
    File["/etc/bird6.d/${name}.conf"]{
      content => $content,
    }
  } else {
    File["/etc/bird6.d/${name}.conf"]{
      source => $source,
    }
  }
}
