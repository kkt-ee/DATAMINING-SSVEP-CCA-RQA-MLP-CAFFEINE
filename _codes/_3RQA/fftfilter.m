function filtersignal = fftfilter(ori_signal,lowband,highband)
%This is a program for bandpass filtering using FFT 
%Author: Hui Yang
%Affiliation: 
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com
%ori_signal: input time series
%lowband: low band 
%highband: high band

%Note: It will be better for the length of input time series to be 2 power

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, “Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,” IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

fs=1000;
passband(1) = lowband;
passband(2) = highband;

N = length(ori_signal);
y = fft(ori_signal);

lowicut = round(passband(1)*N/fs);
lowmirror = N-lowicut+2;

highicut =  round(passband(2)*N/fs);
highmirror = N-highicut+2;

y([1:(lowicut-1) (lowmirror+1):end])=0;
y((highicut+1):(highmirror-1))=0;

filtersignal = ifft(y);


