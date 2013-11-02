class mediatum inherits params {
  anchor { 'mediatum::start': }   ->
  class { 'mediatum::package': }  ->
  class { 'mediatum::config': }   ~>
  class { 'mediatum::service': }  ->
  Class [ 'mediatum' ]            ->
  anchor { 'mediatum::end': }
}
