# == Class: tomcat
#
# A module to deploy and remove tomcat.
#
# See params.pp for configuration.
# 
class tomcat {

  include tomcat::params

  class {'tomcat::accounts': }
  class {'tomcat::packages': }
  class {'tomcat::service': }
  
  tomcat::deploy { [ 'sample1.war', 'sample2.war', 'sample3.war' ]: }
}
