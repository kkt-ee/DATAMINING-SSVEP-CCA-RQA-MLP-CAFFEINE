%%
%loadfiledata=load("P1AS1.lvm");
%%
%[A t Fs]=amptfs(loadfiledata);

%%
[A_r, t_r,augmentedR] = locateR(A,t,Fs,.9); 

%% 3. finding R-peak amplitude, R-peak time, Augmented R-peak | A_r, t_r, augmentedR
function [A_r, t_r,augmentedR] = locateR(A,t,Fs,threshold)
%%
%signalAnalyzer
figure, plot(t,A)
hold on
pause
%% Band pass filter
bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',12,'HalfPowerFrequency2',24,'SampleRate', Fs);
ecgfiltered = filtfilt(bandFilt,A);
plot(t,ecgfiltered)
pause
%% Squaring and smoothening; scaling and smoothening
ecgfilteredsq=ecgfiltered.^2;
plot(t,ecgfilteredsq)
pause
augmentedR=smooth(ecgfilteredsq,30);
plot(t,augmentedR)
pause
augmentedR=augmentedR.*100;
augmentedR=smooth(augmentedR,70);
 plot(t,augmentedR)
pause
[A_r, t_r] = findpeaks(augmentedR,'MinPeakHeight',.9,'MinPeakDistance',threshold);   % default threshold .9
end