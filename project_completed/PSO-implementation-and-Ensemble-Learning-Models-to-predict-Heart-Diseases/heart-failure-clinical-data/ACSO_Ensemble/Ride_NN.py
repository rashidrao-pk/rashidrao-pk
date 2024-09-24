# import all necessery libraries
from numpy import random, dot, tanh
import numpy as np
from Proposed_ACSO_ensemble_classifier import rider
import os
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
    def forward_propagation(self, inputs):
        return self.tanh(dot(inputs, self.weight_matrix)), random.uniform(0, 4, size=len(inputs))

    # training the neural network.
    def train(self, train_inputs, train_outputs,
              num_train_iterations):
        # Number of iterations we want to
        # perform for this set of input.
        for iteration in range(num_train_iterations):
            output, x = self.forward_propagation(train_inputs)

            # Calculate the error in the output.
            error = train_outputs - output

            # multiply the error by input and then
            # by gradient of tanh funtion to calculate
            # the adjustment needs to be made in weights
            adjustment = dot(train_inputs.T, error *
                             self.tanh_derivative(output))

            # Adjust the weight matrix
            self.weight_matrix += adjustment * rider.Alg()


def classify(x_train, x_test, y_train):
    nc = 5
    train_outputs = np.array([y_train]).T
    neural_network = NeuralNetwork(len(x_train[0]))
    neural_network.train(np.array(x_train), train_outputs, 10)

    # Test the neural network with a new situation.
    x, pred = neural_network.forward_propagation(x_test)

    predict = []
    for i in range(len(pred)):
        predict.append(np.abs(np.round(pred[i])))
    if len(np.unique(predict)) != nc:
        for i in range(nc): predict[i]=i
    return predict
