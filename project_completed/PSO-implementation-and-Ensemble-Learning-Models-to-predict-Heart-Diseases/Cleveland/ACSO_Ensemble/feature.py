from Main import parameter
import numpy as np


# selecting feature by distance value
def select_by_distance(data_t, dist, S):
    s_ind, s_ft = [], []
    for i in range(S): # select S feature
        bst = np.argmin(dist) # with minimum distance (kendall tau)
        s_ind.append(bst+1)   # selected index
        s_ft.append(data_t[bst])   # selected feature
        dist[bst] = float('inf')    # set the index with max. value, to get next best
    return s_ind, s_ft


# main
def selection(data, label, fs, dst):

    kendall_dist = []
    data_trans = np.transpose(data)
    for i in range(len(data_trans)):

        # kendall_tau value of each feature
        kendall_dist.append(parameter.kendall_distance(data_trans[i], label))

    index_sel, feature_sel = select_by_distance(data_trans, kendall_dist, fs)
    selected_feature = np.transpose(feature_sel)
    np.savetxt("processed//3) "+dst+"_selected_index.csv", index_sel, delimiter=',', fmt='%s')
    np.savetxt("processed//3) "+dst+"_selected_feature.csv", selected_feature, delimiter=',', fmt='%s')

    return selected_feature
