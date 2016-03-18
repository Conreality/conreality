#!/usr/bin/env python3
# This is free and unencumbered software released into the public domain.

"""Installation script for the Conreality DDK for Python."""

from codecs import open
from os import path
from setuptools import setup
from shutil import copyfile

def readfile(*filepath):
  with open(path.join(*filepath), encoding='utf-8') as f:
    return f.read()

PWD = path.abspath(path.dirname(__file__))

copyfile(path.join(PWD, '..', '..', 'VERSION'), path.join(PWD, 'VERSION'))
copyfile(path.join(PWD, '..', '..', 'UNLICENSE'), path.join(PWD, 'UNLICENSE'))

VERSION          = readfile(PWD, 'VERSION').rstrip()
LONG_DESCRIPTION = readfile(PWD, 'README.rst')

setup(
  name='conreality',
  version=VERSION,
  description="Conreality DDK for Python",
  long_description=LONG_DESCRIPTION,
  url='https://conreality.org/',
  author='Conreality.org',
  author_email='conreality@googlegroups.com',
  license='Public Domain',
  classifiers=[
    'Development Status :: 3 - Alpha',
    'Environment :: Console',
    'Intended Audience :: Developers',
    'Intended Audience :: Information Technology',
    'Intended Audience :: Science/Research',
    'License :: Public Domain',
    'Natural Language :: English',
    'Operating System :: MacOS :: MacOS X',
    'Operating System :: POSIX',
    'Programming Language :: Python :: 3',
    'Programming Language :: Python :: 3.4',
    'Programming Language :: Python :: 3.5',
    'Topic :: Games/Entertainment :: Simulation',
    'Topic :: Scientific/Engineering :: Human Machine Interfaces',
    'Topic :: Software Development :: Embedded Systems',
    'Topic :: System :: Hardware :: Hardware Drivers',
  ],
  keywords='conreality driver robotics',
  packages=['conreality', 'conreality.ddk', 'conreality.sdk'],
  install_requires=[
    'lupa>=1.2',
    'numpy>=1.10',
  ],
)
