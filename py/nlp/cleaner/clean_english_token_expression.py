# -*- coding: utf-8 -*-

import pandas as pd
import re
from nltk.tokenize import word_tokenize


#### this function substitute "'s" by "is" (exp == is). 
#### WARNING because also treat the saxon genitive
def clean_en_expression_in_token(token_in, exp, logger=None):

    
    try:
        token = token_in.strip()


        if exp == '%':
            token = ' percent ' if token == '%' else token
            token = re.sub(r'%', ' percent ', token)

        if exp == 'is':
            token = ' is ' if token == "\'s" else token
            token = re.sub(r'(\'s)', ' is ', token)

        if exp == 'not':
            token = ' not ' if token == "n\'t" else token
            token = re.sub(r'(n\'t)', ' not ', token)


        token = token.strip()


    except Exception:
        if logger is not None:
            logger.exception("ERROR cleaning \'{0}\' in token \'{1}\'".format(punct_symbol, token_in))
        raise Exception
            
    return token



if __name__ == '__main__':
    phrase = 'To Like something'

    clean_saxon_genitive(phrase)







