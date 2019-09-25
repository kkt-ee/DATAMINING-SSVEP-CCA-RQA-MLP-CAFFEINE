% @kishore
% Dt/ 10-12-2018

%Window size now decided of a moving average filter
%% Title: Computing moving average of the signal
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

%% load signal --4D array
%load /mnt/pd/vars/SSVEPdataB1-6.mat     
%load '/mnt/pd/vars/SSVEPdataB5.mat'
load /mnt/pd/newvar6s/B1to18.mat
SSVEPdata=B; 
whos
%N  =length(sig); % 5121 --constant
%%
for vid=1:18
    for p=1:7
        %%eeg =SSVEPdata(:,:,vid,p);
        for sigid=1:22
            sig=SSVEPdata(sigid,:,vid,p);
%% process  
            % -- for window length selection 'w'
            %[w,sad]=fsad(sig)
            %plt(w,sad,fontSize)
            %pause % <end>
            
            smoothsig=movmean(sig,30);                  % Applying a time window 'w' of n=30
            %plot(sig); pause; hold on
            %plot(smoothsig); hold off
            %pause
            newsig(sigid,:,vid,p)= smoothsig;
            fprintf('1')
        end
        %fprintf('2')
    end
    %fprintf('3')
end

clearvars -except newsig
maSSVEPdata=newsig;
save('/mnt/pd/newvar6s/maSSVEPdataB1-18.mat','maSSVEPdata');
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
