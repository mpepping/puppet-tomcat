# Class: tomcat::service
#
class tomcat::service (
    $direction = $tomcat::params::direction,
    $tomcatservice = $tomcat::params::tomcatservice,
    $tomcatversion = $tomcat::params::tomcatversion,
  ){

  file { "/etc/init.d/${tomcatservice}":
      ensure  => "${direction}",
      source  => "puppet:///modules/tomcat/${tomcatservice}.sh",
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    }


  if $direction == 'present' {
    exec { "/sbin/chkconfig --add ${tomcatservice}":
        require => File["/etc/init.d/${tomcatservice}"],
        unless  => "/sbin/chkconfig --list ${tomcatservice}",
      }
    }

    case $direction {
       present: {
         service { 'tomcat7':
             ensure     => 'running',
             hasstatus  => true,
             hasrestart => true,
             require    => File["/etc/init.d/${tomcatservice}"],
         }
       }
       absent: {
         service { 'tomcat7':
             ensure     => 'stopped',
             hasstatus  => true,
             hasrestart => true,
             require    => File["/etc/init.d/${tomcatservice}"],
         }
       }
       default: { fail "unknown \$direction $ensure for $name" }

  }
}