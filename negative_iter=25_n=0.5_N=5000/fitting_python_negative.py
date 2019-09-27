#使用非线性最小二乘法拟合
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import numpy as np
from math import sqrt
import os

file1=open('file_negative','r')
fig = plt.figure(1)
nrows = 8
ncols = 3
fig, axs = plt.subplots(nrows,ncols,sharex=True,figsize=(22,20))
i=1
for line in file1:
    ax = plt.subplot(nrows,ncols,i)
    word=line.split()
    data=np.loadtxt(word[0])
    x=data[:,0]
    y=data[:,2]
    def func(x, c1, c2, c3, c4, c5):
        tmp=((1j*c3)/(x-c2+(1j*c3)))*(1.0/2.0)
        return c1*tmp.real+c4+c5*abs(x)
    if x[0] > x[len(x)-1]:
        min_=x[len(x)-1]
        max_=x[0]
    else:
        min_=x[0]
        max_=x[len(x)-1]
    guess=(1, (min_+max_)/2.0, 0.005, -0.5, 50)
    bounds_=([0, min_, 0, -10, 0], [10, max_, 1, 0, 200])
    print(guess, bounds_)
    popt, pcov = curve_fit(func, x, y, p0=guess, bounds=bounds_)
    perr = np.sqrt(np.diag(pcov))#standard deviation error
    #popt里面是拟合系数
    c1=popt[0]
    c2=popt[1]
    c3=popt[2]
    c4=popt[3]
    c5=popt[4]
    #协方差
    cov_c1=pcov[0][0]
    cov_c2=pcov[1][1]
    cov_c3=pcov[2][2]
    cov_c4=pcov[3][3]
    cov_c5=pcov[4][4]
    yvals=func(x,c1, c2, c3, c4, c5)
    plot1=plt.plot(x, y, '*',label='original values')
    plot2=plt.plot(x, yvals, 'r',label='fit, '+word[1])
    plt.legend(loc=3)
    # plt.title(word[1])
    print('%s   %f8   %f8    %f8    %f8    %f8    %f8   %f8    %f8    %f8    %f8' % (word[2], c1, c2, c3, c4, c5, perr[0], perr[1], perr[2], perr[3], perr[4]))
    # print('%s   %f8   %f8    %f8    %f8    %f8    %f8   %f8    %f8    %f8    %f8' % (word[2], c1, c2, c3, c4, c5, cov_c1, cov_c2, cov_c3, cov_c4, cov_c5))
    i=i+1
    # os._exit(0)
file1.close()
plt.savefig('negative_python_fit.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
