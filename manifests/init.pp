# == Class: demo_mco_client
#
# Full description of class demo_mco_client here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class demo_mco_client
(
  $package_name = $::demo_mco_client::params::package_name,
  $service_name = $::demo_mco_client::params::service_name,
  $middleware_address = $::demo_mco_client::params::middleware_address,
) inherits ::demo_mco_client::params {

  # validate parameters here
  validate_string($package_name)
  validate_string($service_name)

  include ::demo_mco_client::rspec_monitor
  class { '::demo_mco_client::install': } ->
  class { '::demo_mco_client::config': } ~>
  class { '::demo_mco_client::service': } ->
  Class['::demo_mco_client']
}
