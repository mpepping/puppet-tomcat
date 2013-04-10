# deploy.pp
#
 define tomcat::deploy(
     $webapp    = $title,
     $direction = $tomcat::params::direction,
   ) {

  $tomcatservice = $tomcat::params::tomcatservice
  $webappdir     = $tomcat::params::webappdir

  file { "${webappdir}/${webapp}":
    ensure   => "${direction}",
    source   => "puppet:///modules/tomcat/${webapp}",
    require  => Class["$tomcat::service"],
    notify   => Service["${tomcatservice}"],
  }

}