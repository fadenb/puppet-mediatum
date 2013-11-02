class mediatum::config (
  $config_state   = $mediatum::params::config_state,
  $config_folder  = $mediatum::params::config_folder,
  $config_file    = $mediatum::params::config_file,
  $config_owner   = $mediatum::params::config_owner,
  $config_group   = $mediatum::params::config_group,
  $config_mode    = $mediatum::params::config_mode,

  $cfg_hostname   = $hostname,
  $cfg_port       = $mediatum::params::cfg_port,

) {
  anchor { 'mediatum::config::start': }
  anchor { 'mediatum::config::end': }
  # no chaining arrows to allow puppet to figure out order when removing folder

  file { $config_folder:
    ensure  => $config_state ? {
      'absent' => 'absent',
      default  => 'directory',
    },
    owner   => $config_owner,
    group   => $config_group,
    require => Anchor['mediatum::config::start'],
    before  => Anchor['mediatum::config::end'],

  }
  file { $config_file:
    ensure  => $config_state,
    owner   => $config_owner,
    group   => $config_group,
    mode    => $config_mode,
    content => template('mediatum/mediatum.cfg.erb'),
    require => Anchor['mediatum::config::start'],
    before  => Anchor['mediatum::config::end'],
  }
}
