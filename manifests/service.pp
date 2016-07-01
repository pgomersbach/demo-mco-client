# == Class demo_mco_client::service
#
# This class is meant to be called from demo_mco_client.
# It ensure the service is running.
#
class demo_mco_client::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $::demo_mco_client::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
