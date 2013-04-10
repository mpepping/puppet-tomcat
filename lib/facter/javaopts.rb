# javaopts.rb

Facter.add("javaopts") do
  setcode do
    Facter::Util::Resolution.exec('[ -f /etc/init.d/tomcat7 ] && grep JAVA_OPTS /etc/init.d/tomcat7 | sed "s/export //"')
  end
end