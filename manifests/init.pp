class mediatum {
  anchor { 'mediatum::start': }   ->
  class { 'mediatum::params': }   ->
  class { 'mediatum::package': }  ->
  class { 'mediatum::fixtures': } ->
  class { 'mediatum::config': }   ~>
  class { 'mediatum::service': }  ->
  anchor { 'mediatum::end': }
}
