# Class tomcat::packages
#
class tomcat::packages (
    $direction     = $tomcat::params::direction,
    $javaversion   = $tomcat::params::javaversion,
    $tomcatversion = $tomcat::params::tomcatversion,
  ){

Exec {
  path => [
    '/usr/local/bin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'],
  }

package { "${javaversion}":
    #ensure => "${direction}",
    ensure => 'present',
  }


file { "${tomcatversion}":
  ensure  => "${direction}",
  path    => "/tmp/${tomcatversion}.tar.gz",
  source  => "puppet:///modules/tomcat/${tomcatversion}.tar.gz",
  owner   => 'tomcat',
  group   => 'tomcat',
  mode    => '0644',
  }


if $direction == "present" {
  exec { 'extract':
      require => File["${tomcatversion}"],
      cwd     => '/opt',
      command => "/bin/tar zxf /tmp/${tomcatversion}.tar.gz -C /opt",
      creates => "/opt/${tomcatversion}",
      }

  file { [
    "/opt/${tomcatversion}/conf",
    "/opt/${tomcatversion}/logs",
    "/opt/${tomcatversion}/temp",
    "/opt/${tomcatversion}/work",]:
        ensure   => directory,
        require  => Exec['extract'],
        owner    => 'tomcat',
        group    => 'tomcat',
        recurse  => true,
    }

    # fill-up user tomcat homedir
    #

    file { '/opt/tomcat':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        recurse => true,
      }

    file { '/opt/tomcat/bin':
        ensure  => link,
        target  => "/opt/${tomcatversion}/bin",
      }

    file { '/opt/tomcat/conf':
        ensure  => link,
        target  => "/opt/${tomcatversion}/conf",
      }

    file { '/opt/tomcat/lib':
        ensure  => link,
        target  => "/opt/${tomcatversion}/lib",
      }

    file { '/opt/tomcat/logs':
        ensure  => link,
        target  => "/opt/${tomcatversion}/logs",
      }

    file { '/opt/tomcat/temp':
        ensure  => link,
        target  => "/opt/${tomcatversion}/temp",
      }

    file { '/opt/tomcat/webapps':
        ensure  => link,
        target  => "/opt/${tomcatversion}/webapps",
      }

    file { '/opt/tomcat/work':
        ensure  => link,
        target  => "/opt/${tomcatversion}/work",
      }

    # tomcat config

    file { 'tomcat-users':
        ensure  => "${direction}",
        path    => '/opt/tomcat/conf/tomcat-users.xml',
        mode    => '0644',
        require => File['/opt/tomcat/conf'],
        content => template('tomcat/tomcat-users.xml.erb'),
        notify  => Service[tomcat7]
      }

  } 


if $direction == "absent" {
  file { "/opt/${tomcatversion}":
    ensure => "absent",
    force  => true,
  }
}
}