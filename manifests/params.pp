# == Class demo_mco_client::params
#
# This class is meant to be called from demo_mco_client.
# It sets variables according to platform.
#
class demo_mco_client::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'demo_mco_client'
      $service_name = 'demo_mco_client'
    }
    'RedHat', 'Amazon': {
      $package_name = 'demo_mco_client'
      $service_name = 'demo_mco_client'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
