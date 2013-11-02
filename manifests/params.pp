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
      $config_owner  = 'root'
      $config_group  = 'root'
      $config_mode   = '0755'

      # application config
      $cfg_port       = '8081'

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
