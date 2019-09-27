#!/bin/bash
rm -f coe_h*.dat
i_max=25
for ((j=1;j<=37;j++))
do
    for ((i=0;i<=i_max;i++))
    do
        file="negative_matlab_fit_coefficient_${i}.dat"
        echo $file
        h=`awk '{print $1}' $file |sed -n "${j}p"`
        sed -n "${j}p" $file >> coe_h$h.dat
    done
done
