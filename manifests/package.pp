class mediatum::package (
  $package_name   = $mediatum::params::package_name,
  $package_state  = $mediatum::params::package_state,
  $cfg_module_packages = $mediatum::params::cfg_module_packages,
) {
  anchor { 'mediatum::package::start': }  ->
  package { $package_name:
    ensure => $package_state,
  }                                       ->
  package { $cfg_module_packages:
    ensure => $package_state,
  }                                       ->
  anchor { 'mediatum::package::end': }
}
