# -*- coding: utf-8 -*-
"""
Created on Fri Jul 22 18:39:02 2022

@author: kamra
"""


from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,Flatten,MaxPooling1D
from plib.Ride_NN import classify as cf0
from plib.DNFN import classify as cf1
from plib.DRN_ import classify as cf2
def ensemble_models(i,x_train, y_train,x_test,y_test):
    model=[0]*(i+3)
    model[i]=cf0(x_train, y_train, x_test, y_test)
    model[i+1]=cf1(x_train, y_train, x_test, y_test)
    model[i+2]=cf2(x_train, x_test, y_train,y_test)
    return model
    