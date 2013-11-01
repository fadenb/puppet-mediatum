class mediatum::service (
  $service_state   = $mediatum::params::service_state,
  $service_name    = $mediatum::params::service_name,
  $service_enable  = $mediatum::params::service_enable,
) {
  anchor { 'mediatum::service::start': }
  anchor { 'mediatum::service::end': }

  service { $service_name:
    ensure    => $service_state,
    enable    => $service_enable,
    require   => Anchor['mediatum::service::start'],
    before    => Anchor['mediatum::service::end'],
  }
}
