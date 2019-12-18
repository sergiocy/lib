# -*- coding: utf-8 -*-

import pandas as pd
import re
from nltk.tokenize import word_tokenize


#### CLEAN TOKEN
#### include an if-block for each punctuation symbol to treat
def clean_punctuation_in_token(token_in, punct_symbol, logger=None):

    
    try:
        token = token_in.strip()


        if punct_symbol == ',':
            token = '' if token == ',' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), '', token)
            token = re.sub(r',[^0-9]', ',', token)
        
        if punct_symbol == '\.':
            token = '' if token == '.' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), '', token)
            token = re.sub(r',[^0-9]', '\.', token)

        if punct_symbol == '\(':
            token = '' if token == '(' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == '\)':
            token = '' if token == ')' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == ':':
            token = '' if token == ':' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == ';':
            token = '' if token == ';' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == '\?':
            token = '' if token == '?' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == '!':
            token = '' if token == '!' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == '"':
            token = '' if token == '"' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)

        if punct_symbol == '`':
            token = '' if token == '`' else token
            token = re.sub(r'{0}'.format(str(punct_symbol)), ' ', token)


        token = token.strip()


    except Exception:
        if logger is not None:
            logger.exception("ERROR cleaning \'{0}\' in token \'{1}\'".format(punct_symbol, token_in))
        raise Exception
            
    return token


if __name__ == '__main__':
    phrase = 'To Like something'

    clean_punctuation_in_token(',', phrase)







