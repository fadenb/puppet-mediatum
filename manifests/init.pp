class mediatum (


) inherits params {
  class { 'mediatum::package': }  ->
  class { 'mediatum::config': }   ~>
  class { 'mediatum::service': }  ->
  Class [ 'mediatum' ]
}
