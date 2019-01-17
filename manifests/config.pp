# metricbeat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include metricbeat::config
class metricbeat::config (
  $config_dir           = $::metricbeat::config_dir,
  $config_reload        = $::metricbeat::config_reload,
  $elasticsearch_hosts  = $::metricbeat::elasticsearch::hosts,
  $inputs               = $::metricbeat::inputs,
  $inputs_location      = $::metricbeat::inputs_location,
  $home_path            = $::metricbeat::home_path,
  $logstash_hosts       = $::metricbeat::logstash_hosts,
  $logstash_loadbalance = $::metricbeat::logstash_loadbalance,
  $modules_location     = $::metricbeat::modules_location,
  $shipper_name         = $::metricbeat::shipper_name,
){

  file { $home_path:
    ensure  => 'directory',
    require => Package['metricbeat'],
  }

  file { "${config_dir}/metricbeat.yml":
    ensure  => 'present',
    content => template('metricbeat/metricbeat.yml.erb'),
    notify  => Service['metricbeat'],
    require => Package['metricbeat'],
  }
}
