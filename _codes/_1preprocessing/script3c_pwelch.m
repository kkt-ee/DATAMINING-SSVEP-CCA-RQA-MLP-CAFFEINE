%%
clear all
load  /mnt/pd/vars/mabfSSVEPdataA1-6_w40.mat
whos
%%
close all
clearvars -except mabfSSVEPdata
clc
whos
%% [pxx,f]= pwelch(x,window,noverlap,nfft,fs)
%   x                  input signal vector
%   window             window vector of length nfft
%   noverlap           number of overlapped samples (used for DFT averaging)
%   nfft               number of points in DFT
%   fs                 sample rate in Hz 
%--------------------------

% The following examples use a signal x consisting of a sine wave plus Gaussian noise.  
% Here is the Matlab code to generate x, where sine frequency is 500 Hz and sample rate is 4000 Hz: 
fs= 256;                   % Hz sample rate
Ts= 1/fs;
N= 5120;                   % number of time samples

%% Tuning parameters of this program <<---
    savedir='/mnt/pd/_ccaResult/_pwelchPlots';
    freq=[3 5 10 15 20 25 30]; % Hz% <<------
    volhead=' volunteer #';
        class='A'; classhead='Class'; str1=': ';comma=', '; % <<-----------------enter
        %ch=11;
for ph=5%:7
    %ph=2;            % index of photic freq <<---------------------------enter
    phorig=freq(ph); % original photic freq
    circmarkerat_=[3.2 5.2 10 14.8 20 24.8 30];
    circmarkerat=circmarkerat_(ph);
        
%%
        
    for k=4%1:6
        %for ph=2:7% <<----- 
        for ch=21%1:22 
            sig=mabfSSVEPdata(ch,:,k,ph);   % <<----- x,:,k,x-----------------------------------enter 
            %plot(sig); hold on
             
            %whos
%% Band pass filter
%bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',3,'HalfPowerFrequency2',125,'SampleRate', fs);
%sig = filtfilt(bandFilt,sig);
%plot(sig); hold off
                      
            %% DFT averaging
            nfft =5120/8;  
            noverlap =nfft/2;

            window =rectwin(nfft);
            %window  =hanning(nfft);

            [pxx,f] =pwelch(sig,window,noverlap,nfft,fs);    % W/Hz power spectral density
            PdB_Hz =10*log10(pxx); 
            PdB_bin=10*log10(pxx*fs/nfft); %dBW/bin

            legendname =strcat(classhead, class, str1, ' Ch ', num2str(ch), comma, volhead, num2str(k),' (',num2str(phorig),' Hz)');             % <<---- freq(?)

            index = find(f==circmarkerat);                                                        % <<---- f==?
            disp(index)
            y_point=PdB_bin(index);
            %plot(f,PdB_Hz),grid   % plot 1 hz
            fig=figure();
            plot(f,PdB_Hz,f(index),y_point,'go','MarkerSize',18,'LineWidth',1), grid on   % plot 2 bin rect window
                                                       % plot 3 bin hanning window
            lgd = legend('PSD','Peak location');
            lgd.FontSize = 16;
            
            set(gca,'FontSize',20)
            ax = gca;

            c = ax.Color;
            ax.XGrid = 'on';
            %ax.Color = 'blue';
            ax.XLim = [0 75];
            %ax.YLim = [-inf 10]
            xlabel('Hz','FontSize', 30), ylabel('dBW/bin','FontSize', 30)
            title('30 Hz','Fontsize',40)
%pause
%% (uncomment to save images)
%savefilename =strcat(class,'_vol',num2str(k),'_Ch ', num2str(ch),' (',num2str(phorig),' Hz)');             % <<---- freq(?)
%saveas(fig, fullfile(savedir, savefilename), 'jpeg');
%%
pause
close all %--------------------------(uncomment)
    %end
end
end
end
%%
%clc; clear all ;
%X = 1:0.1:20;
%Y = sin(X);
%index = find(X==5.2);
%Y_point = Y(index)
%--See graphically
%plot(X,Y,X(index),Y_point,'o')
%%
%hold on
% plot X in the range 10 to 11
%Xi = X(X>=0 & X<=11) ;
%Yi = Y(X>=0 & X<=11) ;
%plot(Xi,Yi,'*k')

% plot(x, y, x, g, '.-'), legend('Sin(x)', 'Cos(x)')
% subplot(1,2,1)
% plot(x,y), xlabel('x'),ylabel('exp(–1.5x)*sin(10x)'),axis([0 5 -1 1])

