% @kishore
% Dt/ 10-12-2018

%Window size now decided of a moving average filter
%% Band pass filter and moving mean filter
%
%  Answer: We could determine 
%          "The sum of absolute differences (sad)
%           for different window sizes and plot it" 
%
%  Now pick the smallest window size where the
%  '"sad" seems to start to flatten out'.
%
% Program:
%     -- Implementing on EEG signals
%%

clc
close all
clear all
format long g;
format compact;
fontSize=20;
C=1/256;

%% load signal --4D array
%load /mnt/pd/vars/SSVEPdataB1-6.mat     
%load '/mnt/pd/vars/SSVEPdataB5.mat'
%load /mnt/pd/newvar6s/B1to18.mat
%load /mnt/pd/newvar6s/B1to18.mat
load  /mnt/pd/vars/SSVEPdataB1-6.mat % <<---------------------------------------enter 1/2

fs= 256;                   % Hz sample rate
Ts= 1/fs;
N= 5120;                   % number of time samples

whos
%%
for vx=1:6
    for px=1:7
        %%eeg =SSVEPdata(:,:,vid,p);
        for chx=1:22
            rsig=SSVEPdata(chx,:,vx,px);
            
            if px==1
                %% Low pass filter
                lowFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',1.5,'HalfPowerFrequency2',80,'SampleRate', fs);
                filtsig = filtfilt(lowFilt,rsig); 
                %plot(sig); hold off
            else
                %% Band pass filter
                bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',3,'HalfPowerFrequency2',80,'SampleRate', fs);
                filtsig = filtfilt(bandFilt,rsig);
                %plot(sig); hold off
            end
            %% moving mean filter (w=40)  
            % -- for window length selection 'w'
            %[w,sad]=fsad(sig)
            %plt(w,sad,fontSize)
            %pause % <end>
            
            smoothsig=movmean(filtsig,40);                  % Applying a time window 'w' of n=30 <---- CALCULATE w FROM SCRIPT 3a
            %plot(sig); pause; hold on
            %plot(smoothsig); hold off
            %pause
            newsig(chx,:,vx,px)= smoothsig;
            fprintf('1')
            
            clearvars rsig filtsig smoothsig
        end
        %fprintf('2')
    end
    %fprintf('3')
end

clearvars -except newsig
mabfSSVEPdata=newsig;
save('/mnt/pd/vars/mabfSSVEPdataB1-6_w40.mat','mabfSSVEPdata'); % <<-----------------enter 2/2
clearvars newsig 
fprintf("\n")
whos
%{
%% --Previous functions
%% fN for determining window length 'w'
function [w,sad]= fsad(sig)
w=3:3:51
for k=1:length(w)
    smoothsig=movmean(sig,w(k));
    plot(sig); pause; hold on
    plot(smoothsig); pause, hold off
    sad(k)=sum(abs(smoothsig-sig));
end
end

%% Plot
function plt(w,sad,fontSize)
%subplot(2,1,2);
plot(w,sad,'b*-','LineWidth',2), grid on
xlabel('Window size','FontSize',fontSize)
end
%}


%% CHECK  --by counting 1s
%x='111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
%length(x)
