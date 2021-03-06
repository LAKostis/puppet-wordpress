# Reference
<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

**Classes**

* [`wordpress`](#wordpress): Install WP-CLI tool, use it to download wordpress core, create tables in database, configure WordPress and manage plugins and themes.
* [`wordpress::cli`](#wordpresscli): Install lastest WP-CLI tool.
* [`wordpress::core`](#wordpresscore): Use WP-CLI to download last version of WordPress core, create tables in database and configure WordPress.
* [`wordpress::external_fact`](#wordpressexternal_fact): Deploy files to forge an external fact named 'wordpress'
* [`wordpress::params`](#wordpressparams): Sets defaults values for some variables and parameters.
* [`wordpress::resource`](#wordpressresource): download and manage resources aka plugins and themes.
* [`wordpress::site`](#wordpresssite): Use WP-CLI to download last version of WordPress core, create tables in database and configure WordPress.

**Defined types**

* [`wordpress::config::admin`](#wordpressconfigadmin): Configure settings (name password and email) of one user in the desired state.
* [`wordpress::config::option`](#wordpressconfigoption): Configure an option in the desired state
* [`wordpress::core::config`](#wordpresscoreconfig): configure WordPress instance.
* [`wordpress::core::install`](#wordpresscoreinstall): Downloads and installs WordPress core and language.
* [`wordpress::core::update`](#wordpresscoreupdate): Backup and update WordPress core and language.
* [`wordpress::resource::activate`](#wordpressresourceactivate): Activates an already installed resource aka plugin or theme.
* [`wordpress::resource::install`](#wordpressresourceinstall): Downloads and installs a resource aka plugin or theme.
* [`wordpress::resource::uninstall`](#wordpressresourceuninstall): Uninstall an already installed resource aka plugin or theme.
* [`wordpress::resource::update`](#wordpressresourceupdate): Updates an already installed resource aka plugin or theme.

**Functions**

* [`wordpress::password_hash`](#wordpresspassword_hash): Hash a string

## Classes

### wordpress

Install WP-CLI tool, use it to download wordpress core, create tables in database, configure WordPress and manage plugins and themes.

#### Examples

##### 

```puppet
Configure one WordPress instance for URL wordpress.foo.org by using already existing database server and database account and web server with vhost root '/var/www/wordpress.foo.org'.

  class { 'wordpress':
    settings => {
      'wordpress.foo.org' => {
        owner         => 'wp',
        dbhost        => 'XX.XX.XX.XX',
        dbname        => 'wordpress',
        dbuser        => 'wpuserdb',
        dbpasswd      => 'kiki',
        wproot        => '/var/www/wordpress.foo.org',
        wptitle       => 'hola this wordpress instance is installed by puppet',
        wpadminuser   => 'wpadmin',
        wpadminpasswd => 'lolo',
        wpadminemail  => 'bar@foo.org',
      }
    }
  }

Bellow the datatype of `$settings`. Parameters without a default value are mandatory unless otherwise stated.

  Hash[
    String,                  # The URI of the WordPress instance (like : www.foo.org).
    Hash[
      Enum[
        'ensure',            # Possible values : present, absent, lastest (defaults present).
        'wproot',            # Path where is located root of WordPress instance.
        'owner',             # User that own files of WordPress instance.
        'locale',            # Language used by WordPress instance (defaults en_US).
        'dbhost',            # Address of the database server (must be MySQL or MariaDB).
        'dbname',            # Name of the database where tables of WordPress instance are stored.
        'dbuser',            # User of the database used by wordpress to connect to the database server.
        'dbpasswd',          # Password of the user of the database.
        'dbprefix',          # Set table prefix (defaults wp<random_number_with_4_digits>).
        'wpselfupdate',      # Possible values : disabled , enabled (defaults disabled).
        'wptitle',           # Init title of the WordPress instance.
        'wpadminuser',       # Name of admin account of the WordPress instance.
        'wpadminpasswd',     # Password of the admin account of the WordPress instance.
        'wpadminemail',      # email address of the admin account.
        'wpresources',       # Settings for plugins and themes (not mandatory).
      ],
      Variant[
        String,
        Hash[
          Enum[
            'plugin',
            'theme',
          ],
          Array[
            Hash[
              Enum[
                'name',      # Name of the plugin or theme
                'ensure',    # Possible values : present, absent, latest (defaults present).
              ],
              String
              ]
            ]
          ]
        ]
      ]
    ]
```

#### Parameters

The following parameters are available in the `wordpress` class.

##### `settings`

Data type: `Hash`

Describes all availables settings in this module for all wordpress instances on this node. Defaults to empty hash.

Default value: {}

##### `wparchives_path`

Data type: `Pattern['^/']`

Gives the path where are stored archives done before update managed by puppet (not by WordPress itself with `wpselfupdate`). Defaults to /var/wordpress_archives.

Default value: $wordpress::params::default_wparchives_path

##### `wpcli_url`

Data type: `Pattern['^http']`

Gives the address from which to download the WP-CLI tool. Defaults to 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'.

Default value: $wordpress::params::default_wpcli_url

##### `wpcli_bin`

Data type: `Pattern['^/']`

Gives the path where the WP-CLI tools is deployed. Defaults to '/usr/local/bin/wp'.

Default value: $wordpress::params::default_wpcli_bin

##### `hour_fact_update`

Data type: `Integer[1,23]`

Gives the time (hour between 1 and 23) at which the update of external fact is done (use cron). Defaults to 7.

Default value: $wordpress::params::default_hour_fact_update

### wordpress::cli

Install lastest WP-CLI tool.

* **Note** This class should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::cli` class.

##### `wpcli_url`

Data type: `Pattern['^http']`

http URL where to download the wpcli tool.

##### `wpcli_bin`

Data type: `Pattern['^/']`

The PATH where the wpcli tools is deployed.

##### `ensure`

Data type: `Enum['present','absent']`

The desirated state about wpcli tools. Valid values are 'present', 'absent'. Defaults to 'present'.

Default value: $wordpress::params::default_wpcli_ensure

### wordpress::core

Use WP-CLI to download last version of WordPress core, create tables in database and configure WordPress.

* **Note** This class should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::core` class.

##### `wpcli_bin`

Data type: `Pattern['^/']`

The PATH where the WP-CLI tools is deployed.

##### `wparchives_path`

Data type: `Pattern['^/']`

Gives the path where are stored archives done before update managed by puppet (not by WordPress itself with `wpselfupdate`). Defaults to /var/wordpress_archives.

##### `settings`

Data type: `Wordpress::Settings`

Describes all availables settings in this module for all wordpress instances on this node. Defaults to empty hash.

Default value: {}

### wordpress::external_fact

Deploy files to forge an external fact named 'wordpress'

* **Note** This class should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::external_fact` class.

##### `settings`

Data type: `Wordpress::Settings`

Describes all availables settings in this module for all WordPress instances on this node. Defaults to empty hash.

Default value: {}

##### `hour_fact_update`

Data type: `Integer[1,23]`

Gives the approximate hour (between 1 and 23) when external fact is update (some random is added).

### wordpress::params

Sets defaults values for some variables and parameters.

### wordpress::resource

download and manage resources aka plugins and themes.

* **Note** This class should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::resource` class.

##### `settings`

Data type: `Wordpress::Settings`

Describes all availables settings in this module for all wordpress instances on this node. Defaults to empty hash.

Default value: {}

##### `wpcli_bin`

Data type: `Pattern['^/']`

The PATH where the wpcli tools is deployed. Defaults to '/usr/local/bin/wp'.

### wordpress::site

Use WP-CLI to download last version of WordPress core, create tables in database and configure WordPress.

* **Note** This class should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::site` class.

##### `wpcli_bin`

Data type: `Pattern['^/']`

The PATH where the WP-CLI tools is deployed.

##### `settings`

Data type: `Wordpress::Settings`

Describes all availables settings in this module for all wordpress instances on this node. Defaults to empty hash.

Default value: {}

##### `install_secret_directory`

Data type: `Pattern['^/']`



Default value: $wordpress::params::default_install_secret_directory

## Defined types

### wordpress::config::admin

Configure settings (name password and email) of one user in the desired state.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::config::admin` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

##### `wp_user_login`

The login of the user to be configured (if the login does not exist, a new user is created).

##### `wp_user_passwd`

The desired value of the user's password to be configured.

##### `wp_user_email`

The desired value of the user's email to be configured.

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `wp_admin_login`

Data type: `String`



##### `wp_admin_passwd`

Data type: `String`



##### `wp_admin_email`

Data type: `String`



##### `wp_admin_passwd_hash`

Data type: `String`



Default value: wordpress::password_hash($wp_admin_passwd)

### wordpress::config::option

The name of the option to be configured.
The desired value of the option to be configured.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::config::option` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

##### `wp_option_name`

Data type: `String`



##### `wp_option_value`

Data type: `String`



##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

### wordpress::core::config

configure WordPress instance.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::core::config` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

##### `locale`

Data type: `String`

Language used by WordPress instance (defaults en_US).

##### `db_host`

Data type: `String`

Address of the database server (must be MySQL or MariaDB).

##### `db_name`

Data type: `String`

Name of the database where tables of WordPress instance are stored.

##### `db_user`

Data type: `String`

User of the database used by wordpress to connect to the database server.

##### `db_passwd`

Data type: `String`

Password of the user of the database.

##### `dbprefix`

Data type: `String`

Set table prefix (defaults wp<random_number_with_4_digits>).

##### `wp_title`

Data type: `String`

Init title of the WordPress instance.

##### `wp_admin`

Data type: `String`

Name of admin account of the WordPress instance.

##### `wp_passwd`

Data type: `String`

Password of the admin account of the WordPress instance.

##### `wp_mail`

Data type: `String`

Email address of the admin account.

##### `wpselfupdate`

Data type: `String`

Possible values : disabled , enabled (defaults disabled).

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

### wordpress::core::install

Downloads and installs WordPress core and language.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::core::install` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

##### `locale`

Data type: `String`

Language used by WordPress instance (defaults en_US).

##### `db_host`

Data type: `String`

Address of the database server (must be MySQL or MariaDB).

##### `db_name`

Data type: `String`

Name of the database where tables of WordPress instance are stored.

##### `db_user`

Data type: `String`

User of the database used by wordpress to connect to the database server.

##### `db_passwd`

Data type: `String`

Password of the user of the database.

##### `dbprefix`

Data type: `String`

Set table prefix (defaults wp<random_number_with_4_digits>).

##### `wp_title`

Data type: `String`

Init title of the WordPress instance.

##### `wp_admin`

Data type: `String`

Name of admin account of the WordPress instance.

##### `wp_passwd`

Data type: `String`

Password of the admin account of the WordPress instance.

##### `wp_mail`

Data type: `String`

Email address of the admin account.

##### `wpselfupdate`

Data type: `String`

Possible values : disabled , enabled (defaults disabled).

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

### wordpress::core::update

Backup and update WordPress core and language.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::core::update` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

##### `locale`

Data type: `String`

Language used by WordPress instance (defaults en_US).

##### `wpselfupdate`

Data type: `String`

Possible values : disabled , enabled (defaults disabled).

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `wparchives_path`

Data type: `String`

Gives the path where are stored archives done before update managed by puppet (not by WordPress itself with `wpselfupdate`). Defaults to /var/wordpress_archives.

### wordpress::resource::activate

Activates an already installed resource aka plugin or theme.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::resource::activate` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_resource_type`

Data type: `String`

The type of resource aka plugin or theme.

##### `wp_resource_name`

Data type: `String`

The name of the resource. You can find the name in column `slug` in output of `wp plugin search <search>`.

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

### wordpress::resource::install

Downloads and installs a resource aka plugin or theme.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::resource::install` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_resource_type`

Data type: `String`

The type of resource aka plugin or theme.

##### `wp_resource_name`

Data type: `String`

The name of the resource. You can find the name in column `slug` in output of `wp plugin search <search>`.

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

### wordpress::resource::uninstall

Uninstall an already installed resource aka plugin or theme.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::resource::uninstall` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_resource_type`

Data type: `String`

The type of resource aka plugin or theme.

##### `wp_resource_name`

Data type: `String`

The name of the resource. You can find the name in column `slug` in output of `wp plugin search <search>`.

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

### wordpress::resource::update

Updates an already installed resource aka plugin or theme.

* **Note** This defined type should be considered as private.

#### Parameters

The following parameters are available in the `wordpress::resource::update` defined type.

##### `wp_servername`

Data type: `String`

The URI of the WordPress instance (like : www.foo.org).

##### `wp_resource_type`

Data type: `String`

The type of resource aka plugin or theme.

##### `wp_resource_name`

Data type: `String`

The name of the resource. You can find the name in column `slug` in output of `wp plugin search <search>`.

##### `wp_root`

Data type: `String`

The root path of the WordPress instance.

##### `wpcli_bin`

Data type: `String`

The path of the WP-CLI tool.

##### `owner`

Data type: `String`

The OS account, owner of files of the WordPress instance.

## Functions

### wordpress::password_hash

Type: Ruby 4.x API

Hash a string

#### `wordpress::password_hash(String $password)`

The wordpress::password_hash function.

Returns: `String` the password hash from the clear text password.

##### `password`

Data type: `String`

Plain text password.

