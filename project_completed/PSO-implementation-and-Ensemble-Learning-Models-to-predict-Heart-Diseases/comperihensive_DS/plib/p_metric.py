# -*- coding: utf-8 -*-
"""
Created on Fri Jul 22 14:51:07 2022

@author: kamra
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay


def main_perf_metrics_calc(target, y_pred,n_classes):
    classes = list(range(n_classes))
    cm=confusion_matrix(target,  y_pred)
    disp = ConfusionMatrixDisplay(confusion_matrix=cm,display_labels=classes)
    disp.plot()
    plt.show()
    TP, TN, FN, FP = 0, 0, 0, 0
    unique_clas = np.unique(target)
    for i1 in range(len(unique_clas)):
        c = unique_clas[i1]
        for i in range(len(y_pred)):
            if target[i] == c and y_pred[i] == c:
                TP = TP + 1
            if target[i] != c and y_pred[i] != c:
                TN = TN + 1
            if target[i] == c and y_pred[i] != c:
                FN = FN + 1
            if target[i] != c and y_pred[i] == c:
                FP = FP + 1
    TN = TN/len(unique_clas)
    accuracy  = (TP + TN) / (TP + FP + TN + FN) 
    sensitivity = (TP) / (TP + FN) #sensitivity
    specificity = TN / (TN + FP) 
    precision = (TP) / (TP + FP) 
    f1_score  = (2 * precision * sensitivity) / (precision + sensitivity)
    print('Accuracy, sensitivity, specificity, Precision, F1-score')
    return accuracy,sensitivity, specificity,precision,f1_score
    #return "Accuracy ",accuracy,"Precision ", precision,"Recall ", recall,"F1-score",f1_score

