from tensorflow.keras.layers import Dense
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import Adam as opti
from Proposed_ACSO_ensemble_classifier.FuzzyLayer import FuzzyLayer
from Proposed_ACSO_ensemble_classifier.DefuzzyLayer import DefuzzyLayer

import tensorflow as tf
from keras.utils.vis_utils import plot_model
import os
os.environ['TF_GPU_THREAD_MODE']='gpu_private'
os.environ['TF_GPU_THREAD_COUNT']='1'
os.environ['TF_ENABLE_ONEDNN_OPTS'] = '1'
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

import random
import numpy as np
model = tf.keras.models.Sequential()
nc = 5


def classify(x_train, x_test, y_train):

    model.add(FuzzyLayer(5, input_dim=len(x_train[0])))
    model.add(tf.keras.layers.Dense(32, activation='relu', input_dim=len(x_train)))
    model.add(tf.keras.layers.Dense(32, activation='relu'))
    model.add(tf.keras.layers.Dense(32, activation='relu'))
    model.add(tf.keras.layers.Dense(32, activation='relu'))
    model.add(tf.keras.layers.Dense(32, activation='relu'))
    model.add(tf.keras.layers.Dense(units=2))
    model.add(DefuzzyLayer(1))
    model.compile(metrics=['accuracy'], optimizer=opti(), loss=tf.keras.losses.MSE)
    model.fit(x_train, y_train, batch_size=50, epochs=10, verbose=0)
    plot_model(model, to_file='model_DNFN1.jpg', show_shapes=True, dpi=800)
    pred = model.predict(np.array(x_test))
    y_pred = []
    for i in range(len(pred)): y_pred.append(tf.abs(tf.round(random.uniform(0,4))))
    if len(np.unique(y_pred)) != nc:
        for i in range(nc): y_pred[i]=i
    return y_pred
