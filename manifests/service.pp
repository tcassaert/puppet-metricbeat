# metricbeat::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include metricbeat::service
class metricbeat::service (
  $ensure          = $::metricbeat::ensure,
  $service_ensure  = $::metricbeat::service_ensure,
  $validate_cmd    = $::metricbeat::validate_cmd,
  $validate_config = $::metricbeat::validate_config,
){

  if $ensure == 'present' {
    case $service_ensure {
      'enabled': {
        $_service_ensure = 'running'
        $service_enable = true
      }
      'disabled': {
        $_service_ensure = 'stopped'
        $service_enable = false
      }
      'running': {
        $_service_ensure = 'running'
        $service_enable = false
      }
      default: {
      }
    }
  } else {
    $_service_ensure = 'stopped'
    $service_enable = false
  }

  if $validate_config {
    service { 'metricbeat':
      ensure  => $_service_ensure,
      enable  => $service_enable,
      require => Exec[$validate_cmd],
    }
  } else {
    service { 'metricbeat':
      ensure => $_service_ensure,
      enable => $service_enable,
    }
  }

  exec { $validate_cmd:
    refreshonly => true,
  }
}
