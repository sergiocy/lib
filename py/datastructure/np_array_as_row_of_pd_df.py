# -*- coding: utf-8 -*-

import pandas as pd


def np_array_as_row_of_pd_df(logger = None
                            , np_array = None
                            , pd_colnames_root = None):

    try:
        if pd_colnames_root is not None:
            df = pd.DataFrame(data=np_array.reshape((1, len(np_array)))
                      , columns=['{0}{1}'.format(pd_colnames_root, i) for i in range(1, len(np_array) + 1)]
                      )
        else:
            df = pd.DataFrame(data=np_array.reshape((1, len(np_array))))

    except Exception:
        if logger is not None:
            logger.exception("ERROR converting numpy array to pandas")
        else:
            print("ERROR converting numpy array to pandas")
        raise Exception

    return df

