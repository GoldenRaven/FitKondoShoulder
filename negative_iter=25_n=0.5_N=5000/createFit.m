clear all;
datapath1='dos_Vg_h';
a=load(datapath1,'dos_Vg_h');
datapath3='iter_num';
iter_num=load(datapath3,'iter_num');

x=a(:,1);
y=a(:,3);
fid1=fopen('bounds_matlab','w');
datapath3='init_bounds';
c=load(datapath3,'init_bounds');
init_bound1=c(1,1);
init_bound2=c(1,2);
init_y1=c(1,3);
init_y2=c(1,4);

%if iter_num ~= 0
    datapath2='bounds';
    b=load(datapath2,'bounds');
    lower_=b(1,1);
    upper_=b(1,2);
    for i=1:length(x)
        if x(i)>lower_
          lower_index=i;
          break;
        end
    end
    for i=1:length(x)
        %fprintf('%f',x(i))
        if x(i)>upper_
          upper_index=i;
          break;
        else
          upper_index=length(x);
        end
    end
    fprintf(fid1,'%9.6f  %9.6f\n', [x(lower_index), x(upper_index)]);
    x_new=x(lower_index:upper_index);
    y_new=y(lower_index:upper_index);
    [xData, yData] = prepareCurveData( x_new, y_new );
%else
%    [xData, yData] = prepareCurveData( x, y );
%    fprintf(fid1,'%9.6f  %9.6f\n', [x(1), x(length(x))]);
%end
fclose(fid1);

% Set up fittype and options.
ft = fittype( 'c1*real(sqrt((i*c3)/(x-c2+i*c3)))+c4+c5*abs(x)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Algorithm='Trust-Region';
opts.MaxFunEvals=5000;
opts.MaxIter=5000;
opts.Display = 'Off';
%opts.StartPoint = [(y_new(1)+y_new(length(y_new)))/2.0, (x_new(1)+x_new(length(x_new)))/2.0, 0.05, -1*((y_new(1)+y(length(y_new)))/2.0), 50];
opts.Lower = [init_y1, init_bound1, 0, -2, 0];
opts.Upper = [2*init_y2, init_bound2, 0.01, 0, 120];
fid4=fopen('bound_in_matlab','w');
fprintf(fid4,'%9.6f   %9.6f', [init_bound1, init_bound2]);
fclose(fid4);
%opts.Lower = [0,init_bound1, 0, -5, 0];
%opts.Upper = [y_new(length(y_new)), init_bound2, 0.1, 0, 120]
%opts.Lower = [y_new(1), x_new(1), 0, -10, 0];
%opts.Upper = [y_new(length(y_new)), x_new(length(x_new)), x_new(length(x_new)), 10, 200]
%opts.Lower = [0, 0, 0, -10, 0];
%opts.Upper = [10, 1, 0.1, 10, 200]

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
y1=fitresult(xData);
%y2=c1*real(sqrt((i*c3)/(x-c2+i*c3)));
fitresult
gof

fid=fopen('fit.dat','w');
fprintf(fid,'%9.6f  %9.6f\n',transpose([xData,y1]));
fclose(fid);
%
%% Plot fit with data.
%figure( 'Name', 'h=' );
%h = plot( fitresult, xData, yData);
%hold on;
%%plot(x,y1,y2);
%legend('y vs. x', 'h=0.0?', 'Location', 'NorthEast' );
%% Label axes
%xlabel( 'x' );
%ylabel( 'y' );
%grid on
exit
