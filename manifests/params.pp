class mediatum::params {
  case $::osfamily {
    debian, ubuntu: {
      # packages
      $package_name  = 'mediatum'
      $package_state = 'installed'

      # config meta config
      $config_state  = 'present'
      $config_folder = '/etc/mediatum/'
      $config_file   = '/etc/mediatum/mediatum.cfg'
      $config_owner  = 'mediatum'
      $config_group  = 'mediatum'
      $config_mode   = '0755'

      # application config
      $cfg_hostname         = 'localhost'
      $cfg_port             = '8081'
      $cfg_base_dir         = '/srv/mediatum'
      $cfg_data_dir         = "${cfg_base_dir}/data"
      $cfg_searchstore_dir  = "${cfg_data_dir}/search"
      $cfg_temp_dir         = '/tmp/mediatumtmp' # do not use /tmp as it will create problems with fixture processing
      $cfg_log_dir          = "${cfg_data_dir}/log"

      $cfg_db_host          = 'localhost'
      $cfg_db_port          = '3306'
      $cfg_db_database      = 'mediatum'
      $cfg_db_user          = 'mediatum'
      $cfg_db_pass          = 'mediatum'

      # mediatum modules (default mediatum does not come with extra modules)
      $module_packages    = []
      $module_augeas_conf = ''

      # mediatum fixtures (vanilla mediatum does not come with fixtures)
      $fixtures_sql_commands  = '' # path for puppets file resource "source" parameter e.g. file:///vagrant/foo.sql
      $fixtures_file_archive  = '' # path for puppets file resource "source" parameter e.g. file:///vagrant/foo.tgz

      # service
      $service_state  = 'running'
      $service_name   = 'mediatum'
      $service_enable = true
    }
    default: {
      fail("${module_name} does not (yet) support ${::osfamily}. Feel free to send pull requests :)")
    }
  }
}
