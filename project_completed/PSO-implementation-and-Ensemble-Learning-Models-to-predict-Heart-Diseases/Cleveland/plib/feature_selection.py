# -*- coding: utf-8 -*-
"""
Created on Tue Jul 9 08:10:10 2022

@author: kamran
"""
import time
import numpy as np
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import LinearRegression
from numpy.random import rand
#%%   section_1
def get_error(xtrain, ytrain, x, opts):
    fold = opts['fold']
    xt = fold['xt']
    yt = fold['yt']
    xv = fold['xv']
    yv = fold['yv']
    num_train = np.size(xt, 0)
    num_valid = np.size(xv, 0)
    xtrain = xt[:, x == 1]
    ytrain = yt.reshape(num_train)
    xvalid = xv[:, x == 1]
    yvalid = yv.reshape(num_valid)
    #print('Training') #reachability
    #print(xtrain.shape) #size
    #print(ytrain) #value
    mdl     = LinearRegression() #linear model
    mdl.fit(xtrain, ytrain)
    ypred   = mdl.predict(xvalid)
    error   = mean_squared_error(yvalid, ypred, squared=False)
    
    return error


#%%   section_2

def fitness(xtrain, ytrain, x, opts):
    alpha = 0.99
    beta = 1 - alpha
    max_feat = len(x)
    num_feat = np.sum(x == 1)
    #print(num_feat)
    
    if num_feat == 0: #no feature selected
        cost = 1
    else:
        #print('Get error')
        error = get_error(xtrain, ytrain, x, opts)
        # Objective function
        cost = alpha * error + beta * (num_feat / max_feat) #Hypothesis for binary class
    return cost


#%%   section_3


def init_position(lower_boundary, upper_boundary, N, dim):
    X = np.zeros([N, dim], dtype='float')
    for i in range(N):
        for d in range(dim):
            X[i,d] = lower_boundary[0,d] + (upper_boundary[0,d] - lower_boundary[0,d]) * rand()        
    
    return X


#%%   section_4


def init_velocity(lower_boundary, upper_boundary, N, dim):
    V    = np.zeros([N, dim], dtype='float')
    Vmax = np.zeros([1, dim], dtype='float')
    Vmin = np.zeros([1, dim], dtype='float')
    for d in range(dim):
        Vmax[0,d] = (upper_boundary[0,d] - lower_boundary[0,d]) / 2
        Vmin[0,d] = -Vmax[0,d]
        
    for i in range(N):
        for d in range(dim):
            V[i,d] = Vmin[0,d] + (Vmax[0,d] - Vmin[0,d]) * rand()
        
    return V, Vmax, Vmin


#%%   section_5


def binary_conversion(X, threshold, N, dim):
    Xbin = np.zeros([N, dim], dtype='int')
    for i in range(N):
        for d in range(dim):
            if X[i,d] > threshold:
                Xbin[i,d] = 1
            else:
                Xbin[i,d] = 0
    
    return Xbin


#%%   section_6


def boundary(x, lower_boundary, upper_boundary):
    if x < lower_boundary:
        x = lower_boundary
    if x > upper_boundary:
        x = upper_boundary
    
    return x


#%%   section_7


def feature_select(xtrain, ytrain, opts):
   
    upper_boundary    = 1
    lower_boundary    = 0
    threshold = 0.5
    weight     = 0.9
    c1    = 2      
    c2    = 2    
    
    N        = opts['N']
    max_iter = opts['T']
    weight    = opts['w']
    c1   = opts['c1']
    c2   = opts['c2'] 
    
    # Dimension
    dim = np.size(xtrain, 1)
    if np.size(lower_boundary) == 1:
        upper_boundary = upper_boundary * np.ones([1, dim], dtype='float')
        lower_boundary = lower_boundary * np.ones([1, dim], dtype='float')
        
    # Initialize position & velocity
    X             = init_position(lower_boundary, upper_boundary, N, dim)
    V, Vmax, Vmin = init_velocity(lower_boundary, upper_boundary, N, dim) 
    
    # Pre_processing
    fit   = np.zeros([N, 1], dtype='float')
    Xgb   = np.zeros([1, dim], dtype='float')
    fitG  = float('inf')
    Xpb   = np.zeros([N, dim], dtype='float')
    fitP  = float('inf') * np.ones([N, 1], dtype='float')
    curve = np.zeros([1, max_iter], dtype='float') 
    t     = 0
    
    while t < max_iter:
        # Binary conversion
        Xbin = binary_conversion(X, threshold, N, dim)
        
        # Fitness
        for i in range(N):
            fit[i,0] = fitness(xtrain, ytrain, Xbin[i,:], opts)
            if fit[i,0] < fitP[i,0]:
                Xpb[i,:]  = X[i,:]
                fitP[i,0] = fit[i,0]
            if fitP[i,0] < fitG:
                Xgb[0,:]  = Xpb[i,:]
                fitG      = fitP[i,0]
        
        # Store result
        curve[0,t] = fitG.copy()
        
        print("Iteration:", t + 1)
        print("Best (PSO):", curve[0,t])
        if(curve[0,t]==curve[0,t-1]):
            t=max_iter
        else:
            t += 1
        
        for i in range(N):
            for d in range(dim):
                # Update velocity
                r1     = rand()
                r2     = rand()
                V[i,d] = weight * V[i,d] + c1 * r1 * (Xpb[i,d] - X[i,d]) + c2 * r2 * (Xgb[0,d] - X[i,d]) 
                # Boundary
                V[i,d] = boundary(V[i,d], Vmin[0,d], Vmax[0,d])
                # Update position
                X[i,d] = X[i,d] + V[i,d]
                # Update Boundary
                X[i,d] = boundary(X[i,d], lower_boundary[0,d], upper_boundary[0,d])
    
  
    Gbin       = binary_conversion(Xgb, threshold, 1, dim) 
    Gbin       = Gbin.reshape(dim)
    pos        = np.asarray(range(0, dim))    
    sel_index=np.concatenate((pos[Gbin == 1], pos[Gbin == 0]))
    num_feat   = len(sel_index)
    b_feat=len(pos[Gbin == 1])
    pso_data = {'sf': sel_index, 'c': curve, 'nf': num_feat,'bf': b_feat}
    
    return pso_data


def out_features(X_train, Y_train, opts,xtrain, xvalid, ytrain, yvalid):
        start_time = time.time()
        extract_feat  = feature_select(X_train, Y_train, opts)
        print("Run Time --- %s seconds ---" % (time.time() - start_time))
        sf    = extract_feat['sf']
        bf    = extract_feat['bf']
    # model with selected features
        num_train = np.size(xtrain, 0)
        num_valid = np.size(xvalid, 0)
        x_train   = xtrain[:, sf]
        y_train   = ytrain.reshape(num_train)  # Solve bug
        x_test   = xvalid[:, sf]
        y_test   = yvalid.reshape(num_valid)  # Solve bug
        return x_train, x_test, y_train, y_test,bf
