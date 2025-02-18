#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
# Copyright (c) 2011, Joerg Raedler (Berlin, Germany)
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this list
# of conditions and the following disclaimer. Redistributions in binary form must
# reproduce the above copyright notice, this list of conditions and the following
# disclaimer in the documentation and/or other materials provided with the
# distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import sys, importlib

formats = {
    'CSV' :       'Comma separated values - read by many spreadsheet programs',
    'CSVlocale' : 'Simple CSV with locale number formatting',
    'Gnuplot' :   'File format read by gnuplot, a famous plotting package',
    'netCDF' :    'netCDF is a format for structured multi-dimensional data',
    'netCDF4' :   'netCDF is a format for structured multi-dimensional data (needs python-netCDF4)',
    'MATLAB' :    'MATLAB files are binary files of matrix data',
    'HDF5' :      'HDF5 is a format for structured multi-dimensional data (needs h5py)',
    }

loadedFormats = {}


def export(fmt, dm, varList, fileName=None, formatOptions={}):
    """Export the data of the DyMatFile object `dm` to a data file. `fmt` is the 
    format string, `varList` the list of variables to export. If no `fileName` is 
    given, it will be derived from the mat file name. `formatOptions` will be used 
    in later versions.

    :Arguments:
        - string: fmt
        - DyMolaMat object: dm
        - sequence of strings: varList
        - optional string: fileName
        - optional dictionary: formatOptions
        
    :Returns:
        - None
    """
    if not fmt in formats:
        raise Exception('Unknown export format specified!')
    
    if not fmt in loadedFormats:
        loadedFormats[fmt] = importlib.import_module('.%s' % fmt, package='DyMat.Export')

    return loadedFormats[fmt].export(dm, varList, fileName,formatOptions)

