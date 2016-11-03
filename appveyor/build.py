#!/usr/bin/env python

import argparse
import os
import subprocess
import sys
import platform
import re
from distutils.spawn import find_executable

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
YCMD_DIR = os.path.join(SCRIPT_DIR, '..', 'ycmd')
RACERD_DIR = os.path.join(YCMD_DIR, 'third_party', 'racerd')


def build(args):
    subprocess.check_call([sys.executable,
                           os.path.join(YCMD_DIR, 'build.py'),
                           '--msvc', str(args.msvc),
                           '--clang-completer',
                           '--omnisharp-completer',
                           '--gocode-completer',
                           '--tern-completer'])
    # We separately build Racerd because the script automatically compiles it in
    # debug mode on AppVeyor.
    os.chdir(RACERD_DIR)
    subprocess.check_call(['cargo', 'build', '--release'])


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('--msvc', type=int, choices=[11, 12, 14],
                        default=14, help='choose the Microsoft Visual '
                        'Studio version (default: %(default)s).')

    return parser.parse_args()


def main():
    args = parse_arguments()
    build(args)


if __name__ == '__main__':
    main()
