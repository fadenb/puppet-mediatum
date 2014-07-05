# puppet-mediatum

## Overview
The mediatum module installs, configures and manages the [mediatum](http://mediatum.sourceforge.net/) service.
It is capable of managing private mediatum extensions if they are available as package.

### Usage
```
class { '::mediatum': }
```
This will install mediatum, create a basic (__not suitable for production use__) configuration and start mediatum via the initscript.

The `mediatum` class does not accept parameters. Change settings in [params.pp](/manifests/params.pp) (*not recommended*) or override defaults with hiera (*recommended*).

### Install & configure mediatum modules
To install a mediatum-module (e.g. [surfID](http://ksd.ai.ar.tum.de/?page_id=2420)):
* inform mediatum module which additional packages have to be installed
* pass the module a list of [Augeas](http://augeas.net/) changes to be executed onto the mediatum configuration file

Example YAML for surfID module
```
---
# place keys here
# e.g. mediatum::package::package_state: present
mediatum::package::module_packages:
  - mediatum-surfid
mediatum::config::module_augeas_conf:
  - set services/activate true
  - set surfid/fingerprint_srvc_hostname 127.0.0.1:8080
```

### Load fixtures
If you want to automatically load data into the MySQL DB and place files into mediatums data directory set source for sql commands and file archive (.tgz):

```
mediatum::fixtures::fixtures_sql_commands: file:///vagrant/mediatum.sql
mediatum::fixtures::fixtures_file_archive: file:///vagrant/mediatum_fixtures.tgz
```

* Contents of the .sql file are any commands you can feed into mysql client.
* Contents of the .tgz should be all additional files you want to place in the data directory

*Warning: There is currentlys no check if the fixture loading actions are destructive!*
