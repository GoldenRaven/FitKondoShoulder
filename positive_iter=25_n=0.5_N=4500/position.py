import matplotlib
# Force matplotlib to not use any Xwindows backend."
matplotlib.use('Agg')
import numpy as np
import matplotlib.pyplot as plt

from matplotlib import rc
rc('font',**{'family':'serif','serif':['Times New Roman']})
rc('text', usetex=True)

label_size_=14
note_size=14
legend_size=14
mark_size=3
line_width=1.2
axes_linewidth=1.2

plt.cla
plt.rcParams['axes.linewidth'] = axes_linewidth

line_up=np.loadtxt("positive_h2.dat")
line_down=np.loadtxt("negative_h_plot.dat")
line_eq3=np.loadtxt("delta_h.dat")
# line_down2=np.loadtxt("../dos-uniform_negative2/negative_h2.dat")

axs=plt.figure(figsize=(6,4.5))
plt.axis([0,0.05,-0.02,0.02])

plt.ylabel('peak position',fontsize=label_size_)
plt.xlabel(r'$h$',fontsize=label_size_)

plt.plot(line_up[:,0],line_up[:,1],'rp-',ms=mark_size,lw=line_width,label='up')
plt.plot(line_eq3[:,0],line_eq3[:,1],'k--',ms=mark_size,lw=line_width,label='equation')
plt.plot(line_down[:,0],line_down[:,1],'gp-',ms=mark_size,lw=line_width,label='down')
# plt.plot(line_down2[:,0],line_down2[:,1],'bp-',ms=mark_size,lw=line_width,label='down2')
plt.plot(line_eq3[:,0],line_eq3[:,2],'k--',ms=mark_size,lw=line_width)
# plt.plot(line_up[:,0],-1*line_up[:,1],'b-',ms=mark_size,lw=line_width,label='-1*up')

yticks_=[-0.02, -0.015, -0.01, -0.005, 0, 0.005, 0.01, 0.015, 0.02]
ax1=plt.gca()
ax1.set_yticks(yticks_)
ax1.set_yticklabels(yticks_)

plt.legend(loc='center right', numpoints=3, frameon=False, fontsize=legend_size)
ax1.text(0.022,0.0093,r'$\rm{up}$', fontsize=note_size)
ax1.text(0.022,-0.012,r'$\rm{down}$', fontsize=note_size)
# plt.grid(True)
plt.savefig("split.eps", bbox_inches='tight')
