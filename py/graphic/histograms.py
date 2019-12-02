# -*- coding: utf-8 -*-

import pandas as pd
import numpy as np
from matplotlib import pyplot as plt



####
#### similarity metric based on cosin between vector (for text vectorial representations)    
def graph_histogram_from_df_fields(df, fields=[]):
    print(df)
    
    lst_values = []
    for f in fields:
        lst_values_in_field = []
        [lst_values_in_field.extend(list(lst_val)) for lst_val in df[f]]  
        
        lst_values.extend(lst_values_in_field)
        
    #print(lst_values)
    #print(min(lst_values))
    #print(max(lst_values))
    
    
    # fixed bin size
    #bins = np.arange(-100, 100, 5) # fixed bin size
    
    plt.xlim([min(lst_values), max(lst_values)])
    
    plt.hist(lst_values, alpha=0.5)
    #plt.title('Vector elements ')
    plt.xlabel('variable')
    plt.ylabel('count')
    
    plt.show()
        
        
    


    
if __name__ == '__main__':
    df = ['a', 'girl', 'is', 'brushing', 'her', 'hair']
    
    data = {'id':[1, 2]
            , 'field1':[[0,100,2,3.1],[0,100,2,3.1]]
            , 'field2':[[0,100,2,3.1], [0,100,2,3.1]]} 
  
    # Create DataFrame 
    df = pd.DataFrame(data)   
    graph_histogram_from_df_fields(df, ['field1', 'field2'])
    
    
    






    
    
    
    
    
    
    
    
    
    
    
