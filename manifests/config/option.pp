#
# @summary Configure an option in the desired state
#
#@param wp_servername
#  The URI of the WordPress instance (like : www.foo.org).
#@param wp_root
#  The root path of the WordPress instance.
#@param owner
#  The OS account, owner of files of the WordPress instance.
#@param wp_option_name
# The name of the option to be configured.
#@param wp_option_value
# The desired value of the option to be configured.
#@param wpcli_bin
#  The path of the WP-CLI tool.
#@param json
#  Input data is in JSON or plaintext (default)
#@note This defined type should be considered as private.
#
define wordpress::config::option(
  String $wp_servername,
  String $wp_root,
  String $owner,
  String $wp_option_name,
  String $wp_option_value,
  String $wpcli_bin,
  Optional[Boolean] $json = false,
) {

  $wp_params = $json ? {
    default => '',
    true    => '--format=json',
  }

  exec { "${wp_servername} > update ${wp_option_name}" :
    command => "${wpcli_bin} option update ${wp_option_name} '${wp_option_value}' ${wp_params}",
    cwd     => $wp_root,
    user    => $owner,
    unless  => "${wpcli_bin} option get ${wp_option_name} ${wp_params}| /bin/fgrep -xq '${wp_option_value}'",
  }

}
