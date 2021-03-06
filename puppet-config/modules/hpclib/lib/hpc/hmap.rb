#!/usr/bin/env ruby
##########################################################################
#  Puppet configuration file                                             #
#                                                                        #
#  Copyright (C) 2016 EDF S.A.                                           #
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

# This function tranforms an array into a hash with empty values. Eg:
#
# hpc_atoh([ 'a', 'b', 'c' ])
#
#   returns:
#
# { 'a': {},
#   'b': {},
#   'c': {} }

def hpc_atoh(array)
  result = Hash.new()
  array.each do |value|
    result[value] = Hash.new()
  end
  return result
end

# This function tranforms a hash of keys/values into a hash of hashes. Eg:
#
# hpc_hmap({ 'a': 1, 'b': 2, 'c': 3 }, 'value')
#
#   returns:
#
# { 'a': { 'value': 1 },
#   'b': { 'value': 2 },
#   'c': { 'value': 3 }}

def hpc_hmap(hash, key)
  result = Hash.new()
  hash.each do |xkey, value|
    result[xkey] = { key => value }
  end
  return result
end
