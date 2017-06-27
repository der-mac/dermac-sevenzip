# == Class: sevenzip::install
#
# This is the install-class to install the sevenzip-application
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
class sevenzip::install inherits sevenzip {

  case $::os['name'] {
    'windows': {
      case $::os['release']['full'] {
        '7', '10': {
          # Check installed version against package-version
          if (versioncmp($sevenzip::package_version, String($::sevenzip_installed_version)) > 0) or ($::sevenzip_installed_version == '') {
            notify{"${sevenzip::package_name} :: Version is older, installing Software from ${sevenzip::download_link}": }

            # download install-file
            download_file { "${sevenzip::download_dir}\\${sevenzip::destination_file}":
              url                   => $sevenzip::download_link,
              destination_directory => $sevenzip::download_dir,
              destination_file      => $sevenzip::destination_file,
              proxy_address         => $sevenzip::proxy_address,
              proxy_user            => $sevenzip::proxy_user,
              proxy_password        => $sevenzip::proxy_password,
              is_password_secure    => $sevenzip::is_password_secure
            }

            # Install exe-file
            package { $sevenzip::package_name:
              ensure          => $sevenzip::package_ensure,
              source          => "${sevenzip::download_dir}\\${sevenzip::destination_file}",
              install_options => $sevenzip::install_params,
              require         => Download_file["${sevenzip::download_dir}\\${sevenzip::destination_file}"],
            }
          }
          else {
            # If cleanup true, delete the install-file
            if ( $sevenzip::download_cleanup ) {
              file { "${sevenzip::download_dir}\\${sevenzip::destination_file}":
                ensure => absent,
              }
            }
          }
        }
        default: {
          fail("The ${module_name} module is not supported on Windows Version ${::operatingsystemmajrelease} based system.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
