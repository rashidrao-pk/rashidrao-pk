#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import essential libraries
import numpy as np
import pandas as pd
import warnings
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import normalize
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer
def isnumber(x):
    try:
        float(x)
        return True
    except:
        return False


def get_data(path):
    # setting up options
    pd.set_option('display.max_rows', None)
    pd.set_option('display.max_columns', None)
    pd.set_option('float_format', '{:f}'.format)
    warnings.filterwarnings('ignore')

    # import datasets
    train_df = pd.read_csv(path)
    train_df=train_df[train_df.applymap(isnumber)]
    # converting column without decimal to integer
  

    print(f'Number of rows: {train_df.shape[0]};  Number of columns: {train_df.shape[1]}; No of missing values {sum(train_df.isna().sum())}')

    data=train_df.values
    imp = IterativeImputer(max_iter=10, random_state=0)
    imp.fit(data)
    data=np.round(imp.transform(data))
    
    X_train =data[:,:-1]
    Y_train = data[:,-1]

    return X_train,Y_train,train_df


def minmax_norm(X_train):
    return normalize(X_train)

def data_split(X_train,Y_train,test_size):
    xtrain, xvalid, ytrain, yvalid=train_test_split(X_train, Y_train, test_size=0.2, shuffle=False)
    fold = {'xt':xtrain, 'yt':ytrain, 'xv':xvalid, 'yv':yvalid}
    return xtrain, xvalid, ytrain, yvalid,fold



