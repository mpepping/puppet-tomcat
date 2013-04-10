# Class tomcat::params
#
# This class manages parameters for the Tomcat module
#
# Parameters:
# - The $direction parameter can be present (install) or absent (deinst.).
# - The $javaversion parameter sets the JDK to be used.
# - The $tomcatversion parameter sets the tomcat-version; requires matching tgz.
# - The $tomcatuser is the username for the tomcat service.
# - The $tomcatuid is the uid for the tomcat service.
# - The $tomcatgroup is the groupname for the tomcat service.
# - The $tomcatgid is the gid for the tomcat service.
# - The $webapp array is used to identify the webapps to be deployed
# - The $webappdir paramater sets the directory in which webapps are deployed
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class tomcat::params {

  $direction     = 'absent' # set to present for install, absent for deinstall

  $javaversion   = 'java-1.7.0-openjdk'
  $tomcatversion = 'apache-tomcat-7.0.37'

  $tomcatuser    = 'tomcat'
  $tomcatuid     = '91'
  $tomcatgroup   = 'tomcat'
  $tomcatgid     = '91'
  $tomcatservice = 'tomcat7'
  
  $webapp        = [ 'sample1.war', 'sample2.war', 'sample3.war' ]
  $webappdir     = '/opt/tomcat/webapps'

}
