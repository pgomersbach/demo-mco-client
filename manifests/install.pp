# == Class demo_mco_client::install
#
# This class is called from demo_mco_client for install.
#
class demo_mco_client::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  class { '::mcollective':
    client              => true,
    manage_packages     => false,
    middleware_hosts    => [ $::middleware_address ],
    connector           => 'rabbitmq',
    rabbitmq_vhost      => 'mcollective',
    middleware_user     => 'mcollective',
    middleware_password => 'changeme',
  }

  $mco_packeges = [ 'mcollective-plugins-puppetral', 'mcollective-plugins-process', 'mcollective-plugins-package', 'mcollective-plugins-service', 'mcollective-plugins-nrpe', 'mcollective-plugins-filemgr' ]
  package { $mco_packeges:
    ensure => installed,
  }

}
