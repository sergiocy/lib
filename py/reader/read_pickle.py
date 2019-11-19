# -*- coding: utf-8 -*-

import pandas as pd

def read_pickle_file(file):
    pickle_data = pd.read_pickle(file)
    return pickle_data
        

if __name__ == '__main__':

    print('in module input_processing')
    
 
