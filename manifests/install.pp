# metricbeat::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include metricbeat::install
class metricbeat::install (
  $ensure      = $::metricbeat::ensure,
  $manage_repo = $::metricbeat::manage_repo,
  $repo_url    = $::metricbeat::repo_url,
){
  if $manage_repo {
    if !defined(Yumrepo['elastic']) {
      yumrepo { 'elastic':
        descr    => 'Repository for Elastic rpms',
        enabled  => 1,
        baseurl  => $repo_url,
        gpgcheck => '1',
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
      }
    }
  }

  package { 'metricbeat':
    ensure  => $ensure,
    require => Yumrepo['elastic'],
  }
}
