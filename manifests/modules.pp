# metricbeat::modules
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   metricbeat::modules { 'namevar': }
define metricbeat::modules(
  Enum['enable', 'disable'] $action                   = 'enable',
  String                    $module                   = $title,
  String                    $metricbeat_module_dir    = '/etc/metricbeat/modules.d',

  # Nginx module variables
  Optional[Hash]            $nginx_config_hash        = undef,
  Array[String]             $nginx_hosts              = [ 'http://127.0.0.1' ],
  String                    $nginx_server_status_path = 'server-status',
) {

  if ! defined(Class['metricbeat']) {
      fail('You must include the metricbeat base class before using any metricbeat defined resources')
  }

  if $action == 'enable' {
    file { "${metricbeat_module_dir}/${module}.yml":
      ensure  => 'present',
      content => template("${module_name}/modules/${module}.yml.erb"),
      mode    => '0644',
      notify  => Service['metricbeat'],
    }

  } elsif $action == 'disable' {
    file { "${metricbeat_module_dir}/${module}.yml":
      ensure => 'absent',
      notify => Service['metricbeat'],
    }
  }
}
