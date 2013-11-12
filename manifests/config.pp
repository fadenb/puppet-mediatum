class mediatum::config (
  $config_state   = $mediatum::params::config_state,
  $config_folder  = $mediatum::params::config_folder,
  $config_file    = $mediatum::params::config_file,
  $config_owner   = $mediatum::params::config_owner,
  $config_group   = $mediatum::params::config_group,
  $config_mode    = $mediatum::params::config_mode,

  $cfg_hostname         = $mediatum::params::cfg_hostname,
  $cfg_port             = $mediatum::params::cfg_port,
  $cfg_base_dir         = $mediatum::params::cfg_base_dir,
  $cfg_data_dir         = $mediatum::params::cfg_data_dir,
  $cfg_searchstore_dir  = $mediatum::params::cfg_searchstore_dir,
  $cfg_temp_dir         = $mediatum::params::cfg_temp_dir,
  $cfg_log_dir          = $mediatum::params::cfg_log_dir,

  $cfg_db_host          = $mediatum::params::cfg_db_host,
  $cfg_db_port          = $mediatum::params::cfg_db_port,
  $cfg_db_user          = $mediatum::params::cfg_db_user,
  $cfg_db_pass          = $mediatum::params::cfg_db_pass,
  $cfg_db_database      = $mediatum::params::cfg_db_database,

  $module_augeas_conf = $mediatum::params::module_augeas_conf,
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

  augeas { $config_file:
    changes => $module_augeas_conf,
    context => $config_file,
    require => Anchor['mediatum::config::start'],
    before  => Anchor['mediatum::config::end'],
  }

  # make sure configured folders do exist
  file { [$cfg_base_dir, $cfg_data_dir, $cfg_searchstore_dir, $cfg_temp_dir,
          $cfg_log_dir, ]:
    ensure  => 'directory',
    owner   => $config_owner,
    group   => $config_group,
    require => Anchor['mediatum::config::start'],
    before  => Anchor['mediatum::config::end'],
  }
}
