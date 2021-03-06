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

class slurm::install inherits slurm {

  if $::slurm::packages_manage {
    package { $::slurm::packages:
      ensure => $::slurm::packages_ensure,
    }

    # Install spank plugins. The package names are the prefixed keys of the
    # spank plugins hash.
    $_spank_pkgs = prefix(
                     keys($::slurm::spank_plugins),
                     $::slurm::spank_pkg_prefix)
    $keys = keys($::slurm::spank_plugins)
    package { $_spank_pkgs:
      ensure => $::slurm::packages_ensure,
    }
  }
}
