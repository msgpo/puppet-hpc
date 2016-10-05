##########################################################################
#  Puppet configuration file                                             #
#                                                                        #
#  Copyright (C) 2014-2016 EDF S.A.                                      #
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

class xorg::config inherits xorg {
  # usually /etc/systemd/system/xorg.service
  hpclib::systemd_service { $::xorg::service:
    target => $::xorg::service_file,
    config => $::xorg::_service_options,
  }

  case $::xorg::driver {
    'auto': {
      $_file_ensure  = 'absent'
      $_file_content = undef
    }
    'custom': {
      $_file_ensure  = 'present'
      $_file_content = $::xorg::config_content
    }
    'nvidia': {
      $_file_ensure = 'present'
      # Default to the module template if none is provided
      if $::xorg::config_content == undef and $::xorg::config_source == undef {
        $_file_content = template('xorg/xorg.nvidia.conf.erb')
      } else  {
        $_file_content = $::xorg::config_content
      }
    }
    default: {
      fail("Unsupported xorg driver '${::xorg::driver}', should be: 'auto', 'custom' or 'nvidia'.")
    }
  }

  # usually /etc/X11/xorg.conf
  file { $::xorg::config_file:
    ensure  => $_file_ensure,
    content => $_file_content,
    source  => $::xorg::config_source,
  }

}

