# -*- coding: utf-8 -*-
"""
Created on Thu Jul 28 18:00:07 2022

@author: kamra
"""
import os
import json
import csv
import numpy as np
import matplotlib.pyplot as plt

from plib.data import get_data,minmax_norm,data_split
from plib.feature_selection import out_features
from plib.p_metric import main_perf_metrics_calc

#NN
from numpy import random, dot, tanh
from ACSO_Ensemble import rider

#DNFN & Keras modules and its important APIs
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
from sklearn.model_selection import cross_val_score


os.environ['TF_ENABLE_ONEDNN_OPTS'] = '1'
class NeuralNetwork():

    def __init__(self, dim):
        # Using seed to make sure it'll
        # generate same weights in every run
        random.seed(1)

        # 3x1 Weight matrix
        self.weight_matrix = 2 * random.random((dim, 1)) - 1

    # tanh as activation function
    def tanh(self, x):
        return tanh(x)

        # derivative of tanh function.

    # Needed to calculate the gradients.
    def tanh_derivative(self, x):
        return 1.0 - tanh(x) ** 2

    # forward propagation
    def evaluate(self, inputs,out):
        return self.tanh(dot(inputs, self.weight_matrix)), random.uniform(0, 1, size=len(inputs))

    # training the neural network.
    
    def fit(self, train_inputs, y_train,epochs,batch_size,validation_data,shuffle=False,verbose=1):
        # Number of iterations we want to
        # perform for this set of input.
        train_outputs = np.array([y_train]).T
        for iteration in range(epochs):
            output, x = self.evaluate(train_inputs,5)

            # Calculate the error in the output.
            error = train_outputs - output

            # multiply the error by input and then
            # by gradient of tanh funtion to calculate
            # the adjustment needs to be made in weights
            adjustment = dot(train_inputs.T, error *
                             self.tanh_derivative(output))

            # Adjust the weight matrix
            self.weight_matrix += adjustment * rider.Alg()


def classify(x_train, x_test, y_train,y_test):
    nc = 2
    
    neural_network = NeuralNetwork(len(x_train[0]))
    #neural_network.train(np.array(x_train), train_outputs, 10)

    # Test the neural network with a new situation.
    #x, pred = neural_network.evaluate(x_test)

    #predict = []
    #for i in range(len(pred)):
    #    predict.append(np.abs(np.round(pred[i])))
    #if len(np.unique(predict)) != nc:
    #    for i in range(nc): predict[i]=i
    return neural_network

#y_pred=classify(x_train, x_test, y_train)


#measures =main_perf_metrics_calc(y_test, y_pred)
#print(measures)
#measures_table['NN'] = measures
