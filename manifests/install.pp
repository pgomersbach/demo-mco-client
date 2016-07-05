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

  file{ 'plugindir':
    ensure => directory,
    path   => '/opt/puppetlabs/mcollective/plugins',
  }

  file{ 'mco_plugins':
    path    => $mc_plugindir,
    source  => 'puppet:///modules/profile_mcollective/mcollective/plugins',
    recurse => true,
    require => [ Class[ '::mcollective' ], File['plugindir'] ],
  }

  mcollective::server::setting { 'override identity':
    setting => 'identity',
    value   => $::fqdn,
  }

  mcollective::server::setting { 'set heartbeat_interval':
    setting => 'plugin.rabbitmq.heartbeat_interval',
    value   => '30',
    order   => '50',
  }
}
