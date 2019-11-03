# -*- coding: utf-8 -*-

import os



def remove_file_if_exists(file_path):
    if os.path.exists(file_path):
        os.remove(file_path)


        


    
    

if __name__ == '__main__':

    print('in module input_processing')
    
 
