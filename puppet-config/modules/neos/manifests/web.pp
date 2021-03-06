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

# Generate a paraview `pvsc` file
#
# Content comes from a template, except if `paraview_source` or
# `paraview_content` is provided. If both are provided, `paraview_content`
# is used.
#
# @param apache_file Path of the apache configuration file
# @param paraview_content Content of the pvsc file
# @param paraview_source Source (`file` parameter) of the pvsc file
# @param web_dir where the pvsc file is written
class neos::web (
  $apache_file      = $::neos::web::params::apache_file,
  $paraview_content = undef,
  $paraview_source  = undef,
  $web_dir          = $::neos::web::params::web_dir,
  $neos_options     = {}
) inherits neos::web::params {
  validate_absolute_path($apache_file)
  validate_absolute_path($web_dir)
  validate_hash($neos_options)

  $_neos_options = deep_merge($::neos::params::config_options_default, $neos_options)

  anchor { 'neos::web::begin': } ->
  class { '::neos::web::config': } ->
  anchor { 'neos::web::end': }
}
