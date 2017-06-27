# == Class: sevenzip
#
# Install and configure the sevenzip-application (http://www.7-zip.de/).
#
# === Parameters
#
# [*package_ensure*]
#   Install or remove package
# [*$package_name*]
#   Name of the package in the operatingsystem
# [*$package_version*]
#   sevenzip-version, which should be present on the system
# [*$download_link*]
#   Downloadlink for the sevenzip-version, which should be present on the system
# [*$install_dir*]
#   Install-directory for sevenzip (please do not change)
# [*$download_dir*]
#   Download-directory for the sevenzip-install-file
# [*$destination_file*]
#   Name of the downloaded sevenzip-install-file
# [*$download_cleanup*]
#   Remove the sevenzip-install-file once the installed version is the one
#   that should be installed
# [*$proxy_address*]
#   Proxy-server for the download of the sevenzip-install-file
#   Have a look in the download_module doku
# [*$proxy_user*]
#   Proxy-user for the download of the sevenzip-install-file
#   Have a look in the download_module doku
# [*$proxy_password*]
#   Proxy-passwort for the download of the sevenzip-install-file
#   Have a look in the download_module doku
# [*$is_password_secure*]
#   Switch to change the way that proxyPassword is interpreted from secure string to plaintext
#   Have a look in the download_module doku
#
# === Variables
#
# === Examples
#
#  class { 'sevenzip': }
#
# === Authors
#
# Martin Schneider <martin@dermac.de>
#
# === Copyright
#
# Copyright 2017 Martin Schneider
#
class sevenzip (
  $package_ensure     = $sevenzip::params::package_ensure,
  $package_name       = $sevenzip::params::package_name,
  $package_version    = $sevenzip::params::package_version,
  $install_dir        = $sevenzip::params::install_dir,
  $download_link      = $sevenzip::params::download_link,
  $download_dir       = $sevenzip::params::download_dir,
  $download_cleanup   = $sevenzip::params::download_cleanup,
  $destination_file   = $sevenzip::params::destination_file,
  $proxy_address      = $sevenzip::params::proxy_address,
  $proxy_user         = $sevenzip::params::proxy_user,
  $proxy_password     = $sevenzip::params::proxy_password,
  $is_password_secure = $sevenzip::params::is_password_secure,

) inherits sevenzip::params {

  validate_array($package_name)
  validate_string($package_version)
  validate_absolute_path($install_dir)
  validate_string($download_link)
  validate_absolute_path($download_dir)
  validate_bool($download_cleanup)
  validate_string($destination_file)
  validate_string($proxy_address)
  validate_string($proxy_user)
  validate_string($proxy_password)
  validate_bool($is_password_secure)


  anchor { 'sevenzip::begin': }
  -> class { '::sevenzip::install': }
  -> class { '::sevenzip::config': }
  anchor { 'sevenzip::end': }

}
