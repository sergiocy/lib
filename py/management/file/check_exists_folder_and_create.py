# -*- coding: utf-8 -*-

import os
import traceback


def check_exists_folder_and_create(path_folder):
    if os.path.isdir(path_folder):
        print('folder already exists')
    else:
        print('folder NOT exists')
        try:
            os.mkdir(path_folder)
            print('folder created')
        except Exception:
            traceback.print_exc()




    
    

if __name__ == '__main__':

    print('in module input_processing')
    
 
