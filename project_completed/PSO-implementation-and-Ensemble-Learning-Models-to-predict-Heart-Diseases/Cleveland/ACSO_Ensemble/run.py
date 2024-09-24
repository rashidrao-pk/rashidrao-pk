from sklearn.metrics import accuracy_score
import numpy
from Proposed_ACSO_ensemble_classifier import feature
from sklearn.model_selection import train_test_split
from Proposed_ACSO_ensemble_classifier import DRN, Ride_NN, DNFN
from scipy.spatial import distance
from Main.parameter import bound as arr
import numpy as np


def main_perf_metrics_calc(target, y_pred):

    tp, tn, fn, fp = 0, 0, 0, 0
    unique_clas = np.unique(target)
    for i1 in range(len(unique_clas)):
        c = unique_clas[i1]
        for i in range(len(y_pred)):
            if target[i] == c and y_pred[i] == c:
                tp = tp + 1
            if target[i] != c and y_pred[i] != c:
                tn = tn + 1
            if target[i] == c and y_pred[i] != c:
                fn = fn + 1
            if target[i] != c and y_pred[i] == c:
                fp = fp + 1
    tn = tn/len(unique_clas)
    acc = (tp + tn) / (tp + tn + fp + fn)
    sen = tp / (tp + fn)
    spc = tn / (tn + fp)

    return acc, sen, spc


def calmain(trans_data, target, trp, dst, A, Sn, Sp):

    # Feature selection
    Feature_size = 10
    print("\nFeature Selection by Kendall Tau distance..")
    selected_feature = feature.selection(trans_data, target, Feature_size, dst)

    Tr_per, nc = trp/100, 5
    x_train, x_test, y_train, y_test = train_test_split(selected_feature, target, train_size=Tr_per,stratify=target)
    predict, target = [], []
    for i in range(len(y_train)): predict.append(y_train[i])
    for i in range(len(y_train)): target.append(y_train[i])
    for i in range(len(y_test)): target.append(y_test[i])
    if len(np.unique(y_test)) != nc:
        for i in range(nc): y_test[i]=i

    # prediction
    print("\nHeart disease prediction by Ensemble classifiers..")
    N_OUT = [DRN.classify(x_train, y_train, x_test, y_test),    # DRN (Deep Residual Network)
             Ride_NN.classify(x_train, x_test, y_train),    # RideNN
             DNFN.classify(np.array(x_train), np.array(x_test), np.array(y_train))]   # DNFN (Deep Neuro Fuzzy Network)

    # Fisher score
    def fisher_score_calculation(O):
        data = x_test
        uni_cls = np.unique(O)      # number of classes
        n_features = len(data[0])   # number of features
        μi = np.mean(data, axis = 0)    # feature(column) mean

        # data in each class
        def get_data_in_class(data, O, uni_c):
            c_data = []
            for j in range(len(O)):
                if O[j] == uni_c:
                    c_data.append(data[j])
            return c_data

        fisher_score = []   # fisher score of each class.
        for j in range(len(uni_cls)):
            class_data = get_data_in_class(data, O, uni_cls[j])    # data of each class
            nj = len(class_data)    # number of instances in jth class
            μij = np.mean(class_data, axis =0)  # mean of ith feature in jth class
            Pij = np.var(class_data, axis =0)   # variance of ith feature in jth class
            summ_n, summ_d = 0, 0
            for i in range(n_features): # ith feature of jth class
                summ_n += (nj * ((μij[i] - μi[i])**2))
                summ_d += (nj * ((Pij[i])**2))
            if summ_d == 0: FS = summ_n
            else: FS = summ_n/summ_d # Fisher score
            fisher_score.append(FS)

        return fisher_score

    # Fisher score of feature with predicted output (3 network)
    F1 = list(map(fisher_score_calculation, N_OUT))
    F_ = fisher_score_calculation(y_test)   # Fisher score of feature with target

    # Euclidean distance
    def euclidean_dist(fs):
        return distance.euclidean(F_, fs)

    # Euclidean distance of fisher score of target with fisher score of pred. output
    dist = list(map(euclidean_dist, F1))
    F = np.argmin(dist) # network output with min distance
    pred = N_OUT[F]
    for i in range(len(pred)): predict.append(pred[i])
    acc, sen, spe = main_perf_metrics_calc(target, predict)
    A.append(arr(acc))
    Sn.append(arr(sen))
    Sp.append(arr(spe))
