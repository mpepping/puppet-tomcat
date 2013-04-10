# Class tomcat::accounts
#
class tomcat::accounts(
    $direction   = $tomcat::params::direction,
    $tomcatuser  = $tomcat::params::tomcatuser,
    $tomcatuid   = $tomcat::params::tomcatuid,
    $tomcatgroup = $tomcat::params::tomcatgroup,
    $tomcatgid   = $tomcat::params::tomcatgid,
  ) {

  group { 'deploy':
    ensure => "${direction}",
    gid    => '1200',
  }

  group { "${tomcatgroup}":
    ensure => "${direction}",
    gid    => "${tomcatgid}",
  }

  user { "${tomcatuser}":
    ensure           => "${direction}",
    comment          => 'Tomcat daemon',
    gid              => "${tomcatgid}",
    groups           => ['deploy'],
    home             => '/opt/tomcat/',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => "${tomcatuid}",
    managehome       => true,
  }

  # Bug.9622
  if $direction == 'absent' {
      User["${tomcatuser}"] -> Group["${tomcatgroup}"]
  }

  # user del fails when service is active
  if $direction == 'absent' {
      #Service['tomcat7'] -> User["${tomcatuser}"]
      File['/etc/init.d/tomcat7'] -> User["${tomcatuser}"]
  }


}
