# -*- coding: utf-8 -*-

from .clean_token_punctuation import clean_punctuation_in_token
from .clean_english_token_expression import clean_en_expression_in_token


#### CLEAN ENGLISH TOKEN
def clean_english_token(token_in
                        , lcase=False
                        , lst_punct_to_del=[]
                        , lst_en_exp_to_del=[]
                        , logging_tokens_cleaning=True
                        , logger=None):
    try:
        token = token_in.strip()

        if lcase:
            token = str(token).lower()

        if len(lst_punct_to_del) > 0:
            for punct in lst_punct_to_del:
                token = clean_punctuation_in_token(token, punct, logger=logger)

        if len(lst_en_exp_to_del) > 0:
            for exp in lst_en_exp_to_del:
                token = clean_en_expression_in_token(token, exp, logger=logger)

        token = token.strip()

        if logger is not None and logging_tokens_cleaning:
            logger.info(' - cleaning token \'{0}\''.format(token_in))
            logger.info('\n -->> \'{0}\' -->> \'{1}\''.format(token_in, token))


    except Exception:
        if logger is not None:
            logger.exception("ERROR cleaning token \'{0}\'".format(token_in))
        raise Exception

    return token
