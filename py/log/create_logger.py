# -*- coding: utf-8 -*-

import logging


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
    
 
