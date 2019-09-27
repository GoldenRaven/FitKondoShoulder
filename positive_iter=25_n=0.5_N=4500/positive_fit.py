import matplotlib
# Force matplotlib to not use any Xwindows backend.
matplotlib.use('Agg')
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import os

plt.cla
plt.rcParams['axes.linewidth'] = '0.8'

from matplotlib import rc
rc('font',**{'family':'serif','serif':['Times New Roman']})
rc('text', usetex=True)


files=open('filetoplot','r')
coefficients=open('coefficients','r')
coes=open('coes','r')
pick=np.loadtxt('pick.dat')
coe_last=np.loadtxt('positive_matlab_fit_coefficient_25.dat')
discard=np.loadtxt('discard.dat')
tk=np.loadtxt('tk_Vg0.dat')
delta=np.loadtxt('delta_h.dat')
title_=r"up, $n=0.5, \rm{steps}=4500, iter=25, (c+c')/2$"

plt.figure(figsize=(6, 5))
plt.xlabel('h')
plt.ylabel('T')
plt.axis([0, 0.1, 0, 0.03])
plt.title(title_)
plt.plot(discard[:,0],discard[:,3],'kp',ms=4,label='discarded c3')
plt.plot(pick[:,0],pick[:,3],'rp-',ms=3,lw=1,label='picked c3')
plt.plot(pick[:,0],pick[:,2],'bp-',ms=3,label='picked c2')
plt.plot(delta[:,0],delta[:,1],'b--',ms=3,label=r'equation')
plt.legend()
plt.grid(True)
plt.twinx()
plt.plot(coe_last[:,0],coe_last[:,6],'gp-',ms=3,label='Sum of squares due to error')
plt.legend(loc=2)
plt.savefig('up_h.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
os._exit(0)

i=0
nrows = 12
ncols = 3
fig3, axs3 = plt.subplots(nrows,ncols,sharex=True,figsize=(16,35))
for line3 in coes:
    word4=line3.split()
    coe=np.loadtxt(word4[0])
    ax = plt.subplot(nrows,ncols,i+1)
    plt.title(title_)
    plt.plot(coe[:,2],'bp-',ms=3,label=word4[1]+', c2')
    plt.plot(coe[:,3],'rp-',ms=3,label=word4[1]+', c3')
    plt.legend()
    i=i+1
plt.savefig('c2_c3_iter_h.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
# os._exit(0)

coes=open('coes','r')
i=0
nrows = 12
ncols = 3
fig3, axs3 = plt.subplots(nrows,ncols,sharex=True,figsize=(16,39))
for line3 in coes:
    word4=line3.split()
    coe=np.loadtxt(word4[0])
    ax = plt.subplot(nrows,ncols,i+1)
    plt.title(title_)
    plt.plot(coe[:,7],'bp-',ms=3,label=word4[1]+', lower bound')
    plt.plot(coe[:,8],'rp-',ms=3,label=word4[1]+', upper bound')
    plt.legend()
    i=i+1
plt.savefig('bound.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
# os._exit(0)

i=0
nrows = 9
ncols = 3
word3=list(range(26))
fig2, axs2 = plt.subplots(nrows,ncols,sharex=True,figsize=(16,39))
for line3 in coefficients:
    word3[i]=line3.split()
    coe=np.loadtxt(word3[i][0])
    ax = plt.subplot(nrows,ncols,i+1)
    plt.title(title_)
    plt.plot(coe[:,0], coe[:,2],'rp-',ms=3,label='c2, '+str(i))
    plt.plot(coe[:,0], coe[:,3],'bp-',ms=3,label='c3, '+str(i))
    plt.legend()
    i=i+1
plt.savefig('c2_c3_h_iter.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
# os._exit(0)

fig = plt.figure(1)
nrows = 12
ncols = 3
j=0
for line1 in files:
    fig, axs = plt.subplots(nrows,ncols,sharex=True,figsize=(22,39))
    i=0
    word1=line1.split()
    file2=open(word1[1],'r')
    verline=np.loadtxt(word3[j][0])
    for line2 in file2:
        ax = plt.subplot(nrows,ncols,i+1)
        word2=line2.split()
        lines=np.loadtxt(word2[1])
        fits=np.loadtxt(word2[2])
        plt.plot(lines[:,0],lines[:,1],'bp',markersize=1.4,label=str(word2[0]))
        plt.plot(fits[:,0],fits[:,1],'r',label='fitting')
        # plt.axvline(verline[i,2],c='b')
        plt.axvline(verline[i,2],c='r')
        # plt.axvline(verline[i,10],c='g')
        plt.legend()
        i=i+1
    j=j+1
    plt.savefig(word1[0]+'.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
    file2.close()
files.close()

# plt.savefig('positive_fit.eps', dpi=None, facecolor='w', edgecolor='w', orientation='portrait', format='pdf', bbox_inches='tight')
