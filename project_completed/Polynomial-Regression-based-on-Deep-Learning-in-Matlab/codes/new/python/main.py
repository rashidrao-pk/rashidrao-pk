import tensorflow as tf
from sklearn.model_selection import train_test_split
import numpy as np
from random import random
import pandas as pd

def generate_dataset( test_size=0.33):
    """Generates train/test data for sum operation

    :param num_samples (int): Num of total samples in dataset
    :param test_size (int): Ratio of num_samples used as test set
    :return x_train (ndarray): 2d array with input data for training
    :return x_test (ndarray): 2d array with input data for testing
    :return y_train (ndarray): 2d array with target data for training
    :return y_test (ndarray): 2d array with target data for testing

    """
    dataset = pd.read_csv('charpyData.csv')
    x=dataset.iloc[:,:-1].values
    y=dataset.iloc[:,1].values
    # split dataset into test and training sets
    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=test_size)
    return x_train, x_test, y_train, y_test


if __name__ == "__main__":

    # create a dataset with 2000 samples
    x_train, x_test, y_train, y_test = generate_dataset(0.2)

    # build model with 3 layers: 2 -> 5 -> 1
    model = tf.keras.models.Sequential([
      tf.keras.layers.Dense(96, input_dim=16, activation="relu"),
     tf.keras.layers.Dense(256,  activation="relu"),
      tf.keras.layers.Dense(1, activation="sigmoid")
    ])
    model.summary()
    # choose optimiser
    optimizer = tf.keras.optimizers.SGD(learning_rate=0.1)

    # compile model
    model.compile(optimizer=optimizer, loss='mse')

    # train model
    model.fit(x_train, y_train, epochs=100)

    # evaluate model on test set
    print("\nEvaluation on the test set:")
    model.evaluate(x_test,  y_test, verbose=1)

    # get predictions
    predictions = model.predict(x_train)

    # print predictions
    print("\nPredictions and Errors:")
    for d, p in zip(y_test, predictions):
        print("{} - {} = {}".format(d[0], d[1], d[0] - d[1]))
