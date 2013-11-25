class mediatum inherits mediatum::params {
  anchor { 'mediatum::start': }   ->
  class { 'mediatum::package': }  ->
  class { 'mediatum::fixtures': } ->
  class { 'mediatum::config': }   ~>
  class { 'mediatum::service': }  ->
  anchor { 'mediatum::end': }
}
