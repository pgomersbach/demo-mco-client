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
    client           => true,
    manage_packages  => false,
    middleware_hosts => [ $::middleware_address ],
  }
}
