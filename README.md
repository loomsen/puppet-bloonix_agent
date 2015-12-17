# bloonix_agent

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with bloonix_agent](#setup)
    * [What bloonix_agent affects](#what-bloonix_agent-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with bloonix_agent](#beginning-with-bloonix_agent)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The bloonix_agent module installs, configures and manages bloonix-agent

## Module Description
The bloonix_agent module installs, configures and manages bloonix-agent 
and optionally autoregisters with a bloonix server.

## Setup

### What bloonix_agent affects

* This module will set up a repository (depending on your osfamily this is either APT or YUM)
* This module will install the bloonix-agent package on your system
* This module will manage the bloonix-agent config on your system
* This module will manage the bloonix-agent service on your system (optional)

### Setup Requirements **OPTIONAL**

On Debian Systems, this module requires the puppetlabs/apt module.


### If you just want to get started

You need to pass $config_bloonix_server, which should be the fqdn of your
bloonix-server.

```puppet
class { '::bloonix_agent':
  config_bloonix_server => 'bloonix.example.com',
}
```

## Usage

### Connecting to bloonix-server via SSL

```puppet
class { '::bloonix_agent':
  config_bloonix_server => 'bloonix.example.com',
  config_server_use_ssl => true,
}
```
### Enable autoregistration for hosts
See: https://bloonix.org/de/docs/howtos/howto-automated-host-registration.html
Only available in German, but the screenshots should show you enough to know where
to get the company key and id from. In order for the autoregistration to work, you
will need to pass config_bloonix_webgui:

```puppet
class { '::bloonix_agent':
  config_bloonix_server           => 'bloonix.example.com',
  config_bloonix_webgui           => 'http://bloonix.example.com',
  config_register_enable          => true,
  config_register_company_id      => '2',
  config_register_company_authkey => 'theFANCYkeyYOUgotFROMtheGUI',
  config_register_description     => 'You may get fancy with facter facts or something here',
}
```

### Configure the bloonix-agent
You can configure everything in the main.conf file from here. The configuration options are named
config_$as_named_in_bloonix, so bloonix' use_sudo translates to config_use_sudo, bloonix' agents translates to 
config_bloonix_agent and so on. 
Please see params.pp and the bloonix documentation for a full set of options. Here are some examples.

#### Run 2 Agents and set a custom simple_plugins path
```puppet
class { '::bloonix_agent':
  config_bloonix_server => 'bloonix.example.com',
  config_agents         => '2',
  config_simple_plugins => '/usr/local/lib/bloonix/simple-plugins,/usr/lib/bloonix/simple-plugins,/usr/local/bin',
}
```

#### Set a different include path and logfile
```puppet
class { '::bloonix_agent':
  config_bloonix_server => 'bloonix.example.com',
  config_include        => '/usr/local/bloonix/conf.d',
  config_log_filename   => '/usr/local/log/myfancylogfile.log',
}
```
## Reference

### Classes

#### Public Classes
* bloonix_agent: Main class, includes all other classes.

####Private Classes

* bloonix_agent::repo: Sets up the Repo
* bloonix_agent::install: Handles the packages.
* bloonix_agent::config: Handles the configuration file.
* bloonix_agent::service: Handles the service.

###Parameters

The following parameters are available in the `::bloonix_agent` class:

####`package_manage` 
On/Off switch. You can use this to include the module in your site.pp and disable the management for individual nodes.
Or you could go the other way round, and include the module in the main manifest with the toggle off, and enable it for individual nodes.

### Package configuration
####`package_name`                 
Name of the package.
####`package_ensure`
[The package state.](https://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure)

### Basic configuration 
####`config_bloonix_webgui`
The URL to your web-GUI (defaults to http://bloonix.example.com)
####`config_bloonix_server`
The FQDN of your bloonix server (defaults to bloonix.example.com)
####`config_bloonix_server_port`
The port on which the bloonix server listens (defaults to 5460)
####`config_server_use_ssl` 
Should the agent use SSL to talk to the server? (defaults to false)

### More configuration parameters
Please consult [the bloonix documentation](https://bloonix.org/de/docs/configuration/bloonix-agent.html) for a discussion of the params in detail.
####`config_server_mode`
####`config_server_ssl_verify_mode` 
####`config_server_ssl_ca_param`
####`config_server_ssl_ca_file` 
####`config_agents`
####`config_user`
####`config_group`
####`config_plugins`
####`config_simple_plugins`
####`config_use_sudo`
####`config_include`
####`config_register_enable`
####`config_register_company_id`
####`config_register_company_authkey`
####`config_register_template_tags`
####`config_register_description`
####`config_log_filename`  
####`config_log_filelock`
####`config_log_maxlevel`
####`config_log_minlevel`
####`config_log_timeformat`
####`config_log_message_layout`

### Service related configs
####`service_name`
The name of the service (defaults to bloonix-agent)
####`service_ensure`
State of the service (defaults to running)
####`service_enable`
Enable the service? (defaults to true)
####`hostname_re`
Regex used to validate the hostname of the bloonix-server
####`url_re`
Regex used to validate the URL of the bloonix-webgui (in case your installation uses a fancy naming scheme I haven't covered)

## Limitations
Currently, this module support CentOS, Fedora (with the bloonix CentOS Repo), Ubuntu and Debian.

## Development
I have limited access to resources and time, so if you think this module is useful, like it, hate it, want to make it better or
want it off the face of the planet, feel free to get in touch with me.

## Editors
Norbert Varzariu (loomsen)

## Contributors
Please see the [list of contributors.](https://github.com/loomsen/puppet-bloonix_agent/graphs/contributors)

