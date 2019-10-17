# -*- coding: utf-8 -*-

import logging
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



def remove_file_if_exists(file_path):
    if os.path.exists(file_path):
        os.remove(file_path)


def create_logger(log_file_path):

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)
    formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
    hdlr = logging.FileHandler(log_file_path) #logging handle
    hdlr.setFormatter(formatter)
    logger.addHandler(hdlr)

    return logger
        


    
    

if __name__ == '__main__':

    print('in module input_processing')
    
 
