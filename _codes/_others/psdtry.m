Fs = 256;   
%t = 0:1/Fs:2.96;
%x = cos(2*pi*t*1.24e3)+ cos(2*pi*t*10e3)+ randn(size(t));
x=sig;
nfft = 2^nextpow2(length(x));
%%
Pxx = abs(fft(x,nfft)).^2/length(x)/Fs;
%%
Hpsd = dspdata.psd(Pxx(1:length(Pxx)/2),'Fs',Fs);  
plot(Hpsd)