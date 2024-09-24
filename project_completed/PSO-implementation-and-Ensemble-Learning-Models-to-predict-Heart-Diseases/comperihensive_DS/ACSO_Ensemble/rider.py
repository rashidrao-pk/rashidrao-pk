import numpy as np
import math, random


def Alg():
    def success_rate(soln):
        fit = []
        for i in range(len(soln)):
            fit.append(random.random())
        return fit

    Tmax, R, Q = 10, 4, 1  # values of Tmax, R, Q
    X = np.random.random((R, Q))
    B, F, O, A = R / 4, R / 4, R / 4, R / 4  # values of B,F,O,A

    Te = []  # finding the Teta
    for i in range(R):
        Te.append(((i + 1) * 360) // R)
    Phi = 360 // Q  # Finding value of Phi

    T = []  # Finding value of T(steering angle)
    for i in range(R):
        temp = []
        for j in range(Q):
            if j == 0:
                temp.append(Te[i])
            elif temp[j - 1]+Phi <= 360:
                temp.append(temp[j - 1] + Phi)
            else:
                temp.append((temp[j - 1] + Phi) - 360)
        T.append(temp)

    E = np.zeros([4, 1], dtype=int)  # generating E(Gear) 4Dmatrix with zeros
    e = np.zeros([4, 1], dtype=int)  # generating e(Accelerator) 4Dmatrix with zeros
    K = np.zeros([4, 1], dtype=int)  # generating k(Brake) 4Dmatrix with zeros
    Ac = np.zeros([4, 1], dtype=int)  # generating A(Activity counter) 4Dmatrix with zeros

    Emod, Toff, g = 5, 5, 0  # assigning values for Emod  and Toff(Offset Time)

    max1 = []  # To find Vmax, initializing maximum elements in an array
    min1 = []  # initializing minimum elements in an array
    for i in range(len(X)):  # condition for checking each rows till the size of X
        max = np.amax(X[i])  # finding the maximum element in each row
        min = np.amin(X[i])  # finding the minimum element in each row
        max1.append(max)
        min1.append(min)
        # print(max1)
        # print(min1)
    m1 = np.array(max1)  # converting list to array
    m2 = np.array(min1)  # converting list to array
    Vmax = (m1 - m2) / Toff  # finding the values in Vmax
    # print(Vmax)

    VE = ((Vmax) / Toff)  # finding the values of speed limit(VE)
    # print(VE)

    XL = np.zeros([4, 1], dtype=float)  # calculating the success rate, so we are are assuming 0 for XL

    fit = success_rate(X)

    nXL = np.argmax(fit)  # finding the position of maximum value in the fitness
    XL = X[nXL]  # asking to print the row of X which is having the maximum value of fitness(finding the leading rider)
    best_fit = np.max(fit)

    # Loop Begins
    while (g < Tmax):

        Del, Neeta, Epsilon = 0.1, 1, 2  # paramameters(assuming),Neta=random.randint(0,R-1), same(formula) for Epsilon
        Beta = np.array([0.1, 0.2, 0.15])  # assuming
        nX = np.array_split(X, 4)  # Dividing X array into 4 rows
        B = nX[0]  # row of Byepass rider
        F = nX[1]  # row of Follower
        O = nX[2]  # row of Overtaker
        A = nX[3]  # row of Attacker

        X1 = []  # initializing a new X array
        for i in range(len(B)):  # condition till size of Byepass rider
            temp = []
            for j in range(len(B[i])):  # condition till the size of each rows of Byepass rider
                nB = Del * ((X[Neeta][j] * Beta[j]) + (X[Epsilon][j] * (1 - Beta[j])))  # updating the byepass rider
                temp.append(nB)
            X1.append(temp)  # transfering the temp values to X1 matrix

        Pon = (1 / Toff) * Q  # finding the on time probability(Pon)
        j1 = []
        for j in range(len(X1[i])):  # condition for checking till length of  row of newX
            j1.append((j + 1) * Pon)  # product of (j * Pon)
        J = np.asarray(j1)  # converting j1(list) into array

        k = []
        for i in range(len(J)):  # condition for checking till length of J
            if J[i] < Q:  # if each values of J iss less than Q
                k.append(i)  # tranfering the index value of J to k matrix

        V = []
        for i in range(len(F)):  # To find the speed of the follower(condition:till length of F)
            V.append((1 / 3) * (
                    E[len(B) + i] * VE[len(B) + i] + Vmax[len(B) + i] * e[len(B) + i] + (1 - K[len(B) + i]) * Vmax[
                len(B) + i]))  # formula to find V(speed) of follower
        # print(V)

        for i in range(len(F)):  # To find the distance of the follower(condition: till the length of F)
            d = (V[i] * (1 / Toff))  # formula to find the distance of the follower
        # print(d)

        X2 = []  # To update the follower initializing X2 array
        for i in range(len(F)):
            temp = []
            for k in range(len(F[i])):
                nF = XL[k] + (np.cos(T[len(B) + i][k]) * (XL[k]) * (d[i]))  # Formula to update the follower
                temp.append(nF)
            X2.append(temp)  # Transfering the temporary updated values of the follower to the X2

        m = success_rate(fit)  # m is taken as the variable to call the fit from function
        for i in range(len(O)):  # condition till length of overtaker
            f = np.amax(fit)
            SR = fit[len(B) + len(F) + i] / f  # formula to calculate the success rate
        DI = (2 / (1 - math.log(SR)) - 1)  # formula to find the directional indicator(DI) of overtaker

        l1 = (X[len(B) + len(F)]) - (
            XL)  # To find the threshold of the overtaker(here --->X[len(B)+len(F)] denotes(X[2])
        l = abs(l1)  # l=modulus(absolute value of l1)
        Mu = np.mean(l)  # find the mean of l

        k1 = []
        for i in range(len(l)):  # condition for checking till length of l
            if l[i] < Mu:  # if each values of l iss less than Mu
                k1.append(i)  # tranfering the index value of l to k1 matrix

        X3 = O.copy( )  # copied the elements of O in X3 to update the k=3 value
        for i in range(len(O)):
            for k in range(len(O[i])):
                if k in k1:  # conditon to check whether k is present in k1, then update the k=3 value
                    X3[i][k] = (X[len(B) + len(F) + i][k]) + (DI * XL[k])  # formula to update the overtaker

        Va = []  # Speed of attacker
        for i in range(len(A)):  # To find the speed of the attacker(condition:till length of A)
            Va.append((1 / 3) * (E[len(B) + len(F) + len(O) + i] * VE[len(B) + len(F) + len(O) + i] + Vmax[
                len(B) + len(F) + len(O) + i] * e[len(B) + len(F) + len(O) + i] +
                                 (1 - K[len(B) + len(F) + len(O) + i]) * Vmax[
                                     len(B) + len(F) + len(O) + i]))  # formula to find V(speed) of attacker

        for i in range(len(A)):  # To find the distance of the attacker(condition: till the length of A)
            d = (Va[i] * (1 / Toff))  # formula to find the distance of the attacker

        X4 = []
        for i in range(len(A)):
            temp = []
            for j in range(len(A[i])):
                nA = XL[j] + ((np.cos(T[len(B) + len(F) + len(O) + i][j]) * (XL[j]))) + (
                    d[i])  # formula to update the elements of the Attacker
                temp.append(nA)
            X4.append(temp)

        nX = []
        for i in range(len(X1)): nX.append(X1[i])
        for j in range(len(X2)): nX.append(X2[i])
        for k in range(len(X3)): nX.append(X3[i])
        for a in range(len(X4)): nX.append(X4[i])

        X = nX.copy( )
        new_fit = success_rate(X)

        NF = np.argmax(new_fit)  # the position of maximum of newfit
        nXL = np.argmax(fit)  # finding the position of maximum value in the fitness
        if np.max(new_fit) > np.max(fit):
            XL = X[NF]
            best_fit = np.max(new_fit)

        A1 = Ac.copy( )  # updating A matrix as A1
        for i in range(len(fit)):
            if new_fit[i] > fit[i]:
                A1[i] = 1
        # print(A1)

        E1 = E.copy( )  # updating E matrix as E1
        for i in range(R):
            if A1[i]==1 and E[i]!=Emod: E1[i] += 1
            elif A1[i]==0 and E[i]!=0: E1[i] = E[i] - 1
            else: E1[i] = E[i]

        e1 = e.copy( )  # updating e matrix as e1
        e1 = E1 / 5
        K1 = K.copy( )
        K1 = 1 - e1

        T1 = []
        for i in range(R):
            temp = []
            for j in range(Q):
                if A1[i][0] == 0: temp.append(T[i - 1][j])
                elif A1[i][0] == 1:
                    if i == R-1: temp.append(T[0][j])
                    else: temp.append(T[i + 1][j])
            T1.append(temp)
        fit = new_fit.copy( )

        g += 1
    return np.mean(fit)
