function [signal,interval] = rescale_data(signal)
% This program rescale the input signal in the [0,1] interval. 
% Author: Hui Yang
% Affiliation:
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, “Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,” IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

min_signal = min(signal);
max_signal = max(signal);
interval = max_signal-min_signal;
len = length(signal);
if interval~=0
    for i = 1:1:len
        signal(i) =(signal(i)- min_signal)/interval;
    end
else
    fprintf('rescale_data: data interval is zero. It makes no sense to continue. Exiting!');
end