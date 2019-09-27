#!/bin/bash
date > date
iter_max=25
n=0.5
# head -n 1 ../dos-uniform_negative/dos_*
for ((iter_num=0;iter_num<=$iter_max;iter_num++))
do
    echo $iter_num > iter_num
    if [ $iter_num -eq 0 ]
    then
        rm -f negative_matlab_fit_coefficient*.dat dos_Vg0*fit* coe_h*.dat *.eps
        i=1
        for file in ../dos-uniform_negative/dos_Vg0_h0.0*
        do
            # continue
            echo $file $iter_num
            cp $file dos_Vg_h
            bound1=`sed -n "${i}p" init_bound|awk '{print $1}'`
            bound2=`sed -n "${i}p" init_bound|awk '{print $2}'`
            y1=`sed -n "${i}p" init_bound|awk '{print $3}'`
            y2=`sed -n "${i}p" init_bound|awk '{print $4}'`
            echo $bound1 $bound2 > bounds
            echo $bound1 $bound2 $y1 $y2 > init_bounds
            matlab -nodesktop -nosplash -r "createFit" > tmp
            cp fit.dat ${file}_fit_$iter_num
            mv ${file}_fit_$iter_num .
            # exit
            ((i++))
            h=`ls $file|cut -d _ -f 4|cut -d h -f 2`
            c1=`cat tmp|tr -s " "|grep "c1 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c2=`cat tmp|tr -s " "|grep "c2 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c3=`cat tmp|tr -s " "|grep "c3 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c4=`cat tmp|tr -s " "|grep "c4 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c5=`cat tmp|tr -s " "|grep "c5 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            rmse=`cat tmp|tr -s " "|grep "rmse"|cut -d ":" -f 2|awk '{printf("%f"), $1}'`
            lower=`awk '{print $1}' bounds_matlab|awk '{printf("%f"), $1}'`
            upper=`awk '{print $2}' bounds_matlab|awk '{printf("%f"), $1}'`
            bound1=`echo "{print $c2-$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            bound2=`echo "{print $c2+$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            echo $h "  " $c1 " " $c2 "  " $c3 "  " $c4 "  " $c5 "  "$rmse"  "$lower"   "$upper"    "$bound1"  "$bound2>> negative_matlab_fit_coefficient_$iter_num.dat
            # exit
        done
        # echo hi
    elif [ $iter_num -eq 1 ]
    then
        i=1
        for file in ../dos-uniform_negative/dos_Vg0_h0.0*
        do
            cp $file dos_Vg_h
            ((iter_tmp=$iter_num-1))
            echo $file $iter_num
            init_bound1=`sed -n "${i}p" init_bound|awk '{print $1}'`
            init_bound2=`sed -n "${i}p" init_bound|awk '{print $2}'`
            y1=`sed -n "${i}p" init_bound|awk '{print $3}'`
            y2=`sed -n "${i}p" init_bound|awk '{print $4}'`
            echo $init_bound1 $init_bound2 $y1 $y2> init_bounds
            bound1=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_tmp}.dat|awk '{print $10}'`
            bound2=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_tmp}.dat|awk '{print $11}'`
            echo $bound1 $bound2 > bounds
            ((i++))
            matlab -nodesktop -nosplash -r "createFit" > tmp
            cp fit.dat ${file}_fit_$iter_num
            mv ${file}_fit_$iter_num .
            h=`ls $file|cut -d _ -f 4|cut -d h -f 2`
            c1=`cat tmp|tr -s " "|grep "c1 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c2=`cat tmp|tr -s " "|grep "c2 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c3=`cat tmp|tr -s " "|grep "c3 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c4=`cat tmp|tr -s " "|grep "c4 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c5=`cat tmp|tr -s " "|grep "c5 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            rmse=`cat tmp|tr -s " "|grep "rmse"|cut -d ":" -f 2|awk '{printf("%f"), $1}'`
            lower=`awk '{print $1}' bounds_matlab|awk '{printf("%f"), $1}'`
            upper=`awk '{print $2}' bounds_matlab|awk '{printf("%f"), $1}'`
            bound1=`echo "{print $c2-$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            bound2=`echo "{print $c2+$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            echo $h "  " $c1 " " $c2 "  " $c3 "  " $c4 "  " $c5 "  "$rmse"  "$lower"   "$upper"    "$bound1"  "$bound2>> negative_matlab_fit_coefficient_$iter_num.dat
        done
    else
        i=1
        for file in ../dos-uniform_negative/dos_Vg0_h0.0*
        do
            cp $file dos_Vg_h
            ((iter_tmp=$iter_num-1))
            ((iter_old=$iter_num-2))
            echo $file $iter_num
            init_bound1=`sed -n "${i}p" init_bound|awk '{print $1}'`
            init_bound2=`sed -n "${i}p" init_bound|awk '{print $2}'`
            y1=`sed -n "${i}p" init_bound|awk '{print $3}'`
            y2=`sed -n "${i}p" init_bound|awk '{print $4}'`
            echo $init_bound1 $init_bound2 $y1 $y2> init_bounds
            bound1=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_old}.dat|awk '{print $10}'`
            bound2=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_old}.dat|awk '{print $11}'`
            bound3=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_tmp}.dat|awk '{print $10}'`
            bound4=`sed -n "${i}p" negative_matlab_fit_coefficient_${iter_tmp}.dat|awk '{print $11}'`
            bound1_=`echo "($bound1+$bound3)/2.0"|bc -l|awk '{printf("%f"), $1}'`
            bound2_=`echo "($bound2+$bound4)/2.0"|bc -l|awk '{printf("%f"), $1}'`
            # exit
            echo $bound1_ $bound2_ > bounds
            ((i++))
            matlab -nodesktop -nosplash -r "createFit" > tmp
            cp fit.dat ${file}_fit_$iter_num
            mv ${file}_fit_$iter_num .
            h=`ls $file|cut -d _ -f 4|cut -d h -f 2`
            c1=`cat tmp|tr -s " "|grep "c1 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c2=`cat tmp|tr -s " "|grep "c2 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c3=`cat tmp|tr -s " "|grep "c3 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c4=`cat tmp|tr -s " "|grep "c4 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            c5=`cat tmp|tr -s " "|grep "c5 ="|cut -d " " -f 4|awk '{printf("%f"), $1}'`
            rmse=`cat tmp|tr -s " "|grep "rmse"|cut -d ":" -f 2|awk '{printf("%f"), $1}'`
            lower=`awk '{print $1}' bounds_matlab|awk '{printf("%f"), $1}'`
            upper=`awk '{print $2}' bounds_matlab|awk '{printf("%f"), $1}'`
            bound1=`echo "{print $c2-$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            bound2=`echo "{print $c2+$n*$c3}"|bc -l|awk '{printf("%f"), $1}'|awk '{printf("%f"), $1}'`
            echo $h "  " $c1 " " $c2 "  " $c3 "  " $c4 "  " $c5 "  "$rmse"  "$lower"   "$upper"    "$bound1"  "$bound2>> negative_matlab_fit_coefficient_$iter_num.dat
        done
    fi
done
for file in negative_matlab_fit_coefficient_*.dat
do
    sort -k1n,1 $file > tmp
    mv tmp $file
done
bash same_h.bash
# python negative_fit.py
rm -f tmp fit.dat # ../dos-uniform_negative/*_fit
date >> date
