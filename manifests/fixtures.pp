class mediatum::fixtures (
  $fixtures_sql_commands = $mediatum::params::fixtures_sql_commands,
  $fixtures_file_archive = $mediatum::params::fixtures_file_archive,

  $cfg_db_host      = $mediatum::params::cfg_db_host,
  $cfg_db_port      = $mediatum::params::cfg_db_port,
  $cfg_db_user      = $mediatum::params::cfg_db_user,
  $cfg_db_pass      = $mediatum::params::cfg_db_pass,
  $cfg_db_database  = $mediatum::params::cfg_db_database,

  $cfg_data_dir = $mediatum::params::cfg_data_dir,
) {
  anchor { 'mediatum::fixtures::start': } ->
  # Get file and make it available locally to allow mysql client to read it
  file { '/tmp/mediatum_fixtures.sql':
    ensure  => present,
    source  => $fixtures_sql_commands,
  }                                       ->
  exec { 'Import mediatum fixtures into database':
    # we assume fixtures are for testing *only* If you use this on a production host prepare yourself to share your mysql credentials with every other user ;)
    command => "/usr/bin/mysql --host=${cfg_db_host} --port=${cfg_db_port} --user=${cfg_db_user} --password=${cfg_db_pass} ${cfg_db_database} < /tmp/mediatum_fixtures.sql",
  }                                       ->
  # write archive contents into a file in order to extract them via archive::extract
  file { '/tmp/mediatum_fixtures.tgz':
    ensure  => present,
    source  => $fixtures_file_archive,
  }                                       ->
  archive::extract { 'mediatum_fixtures':
    target     => $cfg_data_dir,
    src_target => '/tmp/',
    extension  => 'tgz',
  }                                       ->
  anchor { 'mediatum::fixtures::end': }
}
