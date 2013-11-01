class mediatum::package (
  $package_name   = $mediatum::params::package_name,
  $package_state  = $mediatum::params::package_state,
) {
  anchor { 'mediatum::package::start': }  ->
  package { $package_name:
    ensure => $package_state,
  }                                       ->
  anchor { 'mediatum::package::end': }

}
