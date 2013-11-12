class mediatum::package (
  $package_name   = $mediatum::params::package_name,
  $package_state  = $mediatum::params::package_state,
  $module_packages = $mediatum::params::module_packages,
) {
  anchor { 'mediatum::package::start': }  ->
  package { $package_name:
    ensure => $package_state,
  }                                       ->
  package { $module_packages:
    ensure => $package_state,
  }                                       ->
  anchor { 'mediatum::package::end': }
}
