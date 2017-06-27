# == Class: sevenzip::params
#
# This is the paramter-class to configure the sevenzip-module
#
# === Parameters
#
# See the init-class.
#
# === Variables
#
# === Examples
#
# === Authors
#
# Martin Schneider <martin@dermac.de>
#
# === Copyright
#
# Copyright 2017 Martin Schneider
#
class sevenzip::params {

  $package_ensure     = 'present'
  $download_dir       = $::sevenzip_curr_temp_dir
  $download_cleanup   = true
  $proxy_address      = ''
  $proxy_user         = ''
  $proxy_password     = ''
  $is_password_secure = false

  $default_package_version    = '16.04'
  $default_package_name       = ['7-Zip 16.04 (x64)']
  $default_download_link      = 'http://7-zip.org/a/7z1604-x64.msi'
  $default_install_dir        = 'C:\Program Files\7-Zip'

  case $::os['name'] {
    'windows': {
      case $::os['release']['full'] {
        '7', '10': {
          $package_version  = $default_package_version
          $package_name     = $default_package_name
          $download_link    = $default_download_link
          $install_dir      = $default_install_dir
        }
        default: {
          fail("The ${module_name} module is not supported on Windows Version ${::os['release']['full']} based system.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::os['name']} based system.")
    }
  }

  if $download_link =~ /.*\.msi$/ {
    $install_params     = [ '/passive', '/norestart' ]
    $destination_file = "${module_name}_${package_version}.msi"
  }
  elsif $download_link =~ /.*\.exe$/ {
    $install_params     = [ '/S' ]
    $destination_file = "${module_name}_${package_version}.exe"
  }
  else {
    fail("Unsupported installfile (${download_link}). Only .exe and .msi files are supported.")
  }
}
