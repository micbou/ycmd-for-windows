#!/usr/bin/env python

import argparse
import os
import shutil
from zipfile import ZipFile

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
ROOT_DIR = os.path.join(SCRIPT_DIR, '..')
YCMD_DIR = os.path.join(ROOT_DIR, 'ycmd')


def get_files_list():
    files = []
    with open(os.path.join(ROOT_DIR, 'files_list')) as files_list:
        for filepath in files_list:
            files.append(os.path.normpath(filepath.strip()))
    return files


def create_archive(args):
    filepaths_to_keep = get_files_list()
    old_dir = os.getcwd()
    os.chdir(ROOT_DIR)
    with ZipFile(args.archive, 'w') as ycmd_artifact:
        for root, dirs, files in os.walk(YCMD_DIR):
            for filename in files:
                filepath = os.path.relpath(os.path.join(root, filename),
                                           ROOT_DIR)
                if filepath in filepaths_to_keep:
                    ycmd_artifact.write(filepath)
    os.chdir(old_dir)


def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('archive', type=str,
                        help='ycmd archive name.')

    return parser.parse_args()


def main():
    args = parse_arguments()
    create_archive(args)


if __name__ == '__main__':
    main()
