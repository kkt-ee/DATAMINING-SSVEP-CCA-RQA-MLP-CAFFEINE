% @kishore
% Dt/ 10-12-2018

%% Title: How to decide window size of a moving average filter
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
%close all
clear
format long g;
format compact;
fontSize=20;
C=1/256;

whos
%% load signal
%clear
%load '/mnt/pd/vars/SSVEPdataB1-6.mat' % old+1 
%load /mnt/pd/vars/SSVEPdataB1-3.mat   % old+2
load /mnt/pd/vars/bfSSVEPdataB1-6.mat
SSVEPdata=bfSSVEPdata;
whos
%%
%N  =length(sig); % 5121 --constant

for vid=4:6                                  % 3 volunteers
    for p=1:7                                % 7 photic frequencies
        %%eeg =SSVEPdata(:,:,vid,p);
        for sigid=1:22                       % 22 channels
            sig=SSVEPdata(sigid,:,vid,p);
%% process  
            % -- for window length selection 'w'
            [w,sad]=fsad(sig)
            label=strcat('B Volunteer ',num2str(vid),' Stimulus ',num2str(p), ' Channel ',num2str(sigid)) 
            plt(w,sad,label)
            pause % <end>
            
            %smoothsig=movmean(sig,30);
            %plot(sig); pause; hold on
            %plot(smoothsig)
            %pause
            
            newsig(sigid,:,vid,p)= sig;
        end
    end
end
    
    
    
%% 
%function 


%% process
function [w,sad]= fsad(sig)
w=3:3:51
for k=1:length(w)
    smoothsig=movmean(sig,w(k));
    %plot(sig); pause; hold on
    %plot(smoothsig); pause, hold off
    sad(k)=sum(abs(smoothsig-sig));
end
end

%% plot
function plt(w,sad,channel)
%subplot(2,1,2);
plot(w,sad,'b*-','LineWidth',2), grid on

set(gca,'FontSize',20)
xlabel('Window size','FontSize',30), ylabel('SAD','FontSize',30) 
title(channel, 'FontSize',16) 
end
