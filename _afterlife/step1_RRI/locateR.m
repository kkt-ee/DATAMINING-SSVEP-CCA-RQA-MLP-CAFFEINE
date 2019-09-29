%% [FILTER] fn
% STEP 1 : -R-R Interval extract- 


%% 3. finding R-peak amplitude, R-peak time, Augmented R-peak | A_r, t_r, augmentedR
function [A_r, t_r,augmentedR] = locateR(A,t,Fs,threshold)
%%
%signalAnalyzer

%% Band pass filter
bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',12,'HalfPowerFrequency2',24,'SampleRate', Fs);
ecgfiltered = filtfilt(bandFilt,A);

%% Squaring and smoothening; scaling and smoothening
ecgfilteredsq=ecgfiltered.^2;
augmentedR=smooth(ecgfilteredsq,30);

augmentedR=augmentedR.*100;
augmentedR=smooth(augmentedR,70);

[A_r, t_r] = findpeaks(augmentedR,'MinPeakHeight',threshold,'MinPeakDistance',.9);   % default threshold .9
end