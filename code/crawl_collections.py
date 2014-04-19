#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""

"""
from __future__ import print_function
import argparse
import string
import os
import sys
import subprocess
from pprint import pprint as pp

def main(argv=None):
    parser = argparse.ArgumentParser(description=__name__)

    if argv is None:
        argv = parser.parse_args()

    this_dir = os.path.dirname(os.path.abspath(__file__))
    xsl_collections = os.path.join(this_dir, 'xsl_collections.xsl')
    xsl_institutions = os.path.join(this_dir, 'xsl_institutions.xsl')
    
    institutions_file = open(os.path.join(this_dir,'..','institutions','contributors.tsv'),'w')
    print(process_url('http://oac.cdlib.org/institutions/', xsl_institutions), 
          file=institutions_file)

    titles_base = 'http://oac.cdlib.org/titles/'

    title_file = open(os.path.join(this_dir, '..', 'titles',  '0-9_titles.tsv'),'w')
    print_titles(process_url(titles_base, xsl_collections), file=title_file)

    for char in string.ascii_lowercase:
        title_file = open(os.path.join(this_dir, ''.join([char, '_titles.tsv'])),'w')
        print_titles(process_url(''.join([titles_base, char, '.html']), xsl_collections),
            file=title_file)

def print_titles(string, file):
    print(string.replace('http://ark.cdlib.org/ark:','http://www.oac.cdlib.org/findaid/ark:'),
        file=file)


def process_url(url, xsl):
    url = ''.join([url, '?raw=1'])
    return subprocess.check_output(["xsltproc", xsl, url]
        ).replace('<?xml version="1.0"?>\n','')

# main() idiom for importing into REPL for debugging
if __name__ == "__main__":
    sys.exit(main())

"""
Copyright © 2014, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, 
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, 
  this list of conditions and the following disclaimer in the documentation 
  and/or other materials provided with the distribution.
- Neither the name of the University of California nor the names of its
  contributors may be used to endorse or promote products derived from this 
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
POSSIBILITY OF SUCH DAMAGE.
"""
