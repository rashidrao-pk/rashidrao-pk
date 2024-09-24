# -*- coding: utf-8 -*-
"""
Created on Thu Jul 28 17:57:38 2022

@author: kamra
"""

#DNFN & Keras modules and its important APIs
import os
import tensorflow as tf
from keras.utils.vis_utils import plot_model
import keras
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.regularizers import l2
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Dense,Activation, Flatten,BatchNormalization
from tensorflow.keras.layers import Conv2D, AveragePooling2D, Input
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import Adam as opti

#from ACSO_Ensemble.FuzzyLayer import FuzzyLayer
from ACSO_Ensemble.DefuzzyLayer import DefuzzyLayer



#DNFN
os.environ['TF_GPU_THREAD_MODE']='gpu_private'
os.environ['TF_GPU_THREAD_COUNT']='1'
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '1'
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

model = tf.keras.models.Sequential()
nc = 2


def classify(x_train, x_test, y_train,y_test):
    print(x_train.shape[1])
    model.add(Dense(5, input_shape=(x_train.shape[1],)))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(units=2))
    model.add(Dense(1,activation='sigmoid'))
    model.compile(metrics=['accuracy'], optimizer=opti(), loss=tf.keras.losses.MSE)
    return model
