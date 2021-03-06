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

#
class boothttp::params {

  $ip              = undef
  $port            = '3138'
  $packages_ensure = 'installed'
  $packages        = [
    'python-yaml'
  ]

  $config_dir_http   = '/var/www'
  # Wrong default value, must be set either by autolookup or by the calling
  # profile.
  $menu_source       = 'http://files.hpc.example.com/boot/cgi/bootmenu.py'
  $menu_config       = '/etc/hpc-config/bootmenu.yaml'

  $hpc_files = {}
  $archives  = {}

  $install_options = {}

  $supported_os = [
    'calibre9',
    'rhel6',
  ]

}
