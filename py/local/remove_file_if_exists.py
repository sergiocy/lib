# -*- coding: utf-8 -*-

import os



def remove_file_if_exists(file_path, logger = None):
    if os.path.exists(file_path):
        os.remove(file_path)
        if logger is not None:
            logger.info('file deleted')
        else:
            print('file deleted')


        


    
    

if __name__ == '__main__':

    print('in module input_processing')
    
 
