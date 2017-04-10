##########################################################################
#  Puppet configuration file                                             #
#                                                                        #
#  Copyright (C) 2014-2017 EDF S.A.                                      #
#  Contact: CCN-HPC <dsp-cspit-ccn-hpc@edf.fr>                           #
#                                                                        #
#  This program is free software; you can redistribute in and/or         #
#  modify it under the terms of the GNU General Public License,          #
#  version 2, as published by the Free Software Foundation.              #
#  This program is distributed in the hope that it will be useful,       #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#  GNU General Public License for more details.                          #
##########################################################################

class network::config inherits network {

  if $::network::config_manage {

    # Set hostname
    augeas { $::network::hostname_augeas_path:
      context => $::network::hostname_augeas_path,
      changes => $::network::hostname_augeas_change,
    }

    host { 'localhost':
      ensure => present,
      ip     => '127.0.0.1',
    }

    host { $::network::fqdn:
      ensure       => present,
      ip           => $::hostfile[$::hostname],
      host_aliases => $::hostname,
    }

    # $net_ifaces hash is used by create_resources to generate main network
    # configuration file. On debian systems there is a single file.
    # On RHEL systems there is a file for each interface. For this reason
    # the hash is modified with the names of all interfaces in the case of RHEL.
    $net_ifaces = $::ifaces_target
    create_resources(network::print_config, $net_ifaces)

  }

}
