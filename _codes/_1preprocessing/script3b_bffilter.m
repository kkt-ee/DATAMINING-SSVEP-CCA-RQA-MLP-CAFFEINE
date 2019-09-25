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
            
            %% Band pass filter
            bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',1.5,'HalfPowerFrequency2',80,'SampleRate', fs);
            filtsig = filtfilt(bandFilt,rsig);
            %plot(filtsig); hold off
            
            newsig(chx,:,vx,px)= filtsig;
            fprintf('1')
            
            clearvars rsig filtsig 
        end
        %fprintf('2')
    end
    %fprintf('3')
end

clearvars -except newsig
bfSSVEPdata=newsig;
save('/mnt/pd/vars/bfSSVEPdataB1-6.mat','bfSSVEPdata'); % <<-----------------enter 2/2
clearvars newsig 
fprintf("\n")
whos


%% CHECK  --by counting 1s
%x='111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
%length(x)
