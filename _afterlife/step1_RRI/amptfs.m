%% [SUPPORTING] fn
% STEP 1 : -R-R Interval extract- 

% 2. Amplitude, time, sampling frequency |[A, t, Fs]
%                             .... returns A, t, Fs from the .lvm file data

function [A t Fs]=amptfs(loadfiledata)
A=loadfiledata(:,2);
t=loadfiledata(:,1);
Fs=1/(t(2)-t(1));
end