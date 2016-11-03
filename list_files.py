#!/usr/bin/env python

import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
YCMD_DIR = os.path.join(SCRIPT_DIR, 'ycmd')



def create_files_list():
    with open('files_list', 'w', encoding='utf8') as files_list:
        for root, dirs, files in os.walk(YCMD_DIR):
            for filepath in files:
                listed_file = os.path.relpath(os.path.join(root, filepath),
                                              YCMD_DIR)
                files_list.write(listed_file)
                files_list.write('\n')


def main():
    create_files_list()


if __name__ == '__main__':
    main()
