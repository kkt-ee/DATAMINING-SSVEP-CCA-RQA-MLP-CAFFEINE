%% [CORE]
% STEP 1 : -R-R Interval  extract- 

%% 4. finding R-R interval | RRinterval
function [RRinterval] = rri(t_r)
for i =1:length(t_r)-1
    RRinterval(i,1) = abs(t_r(i+1)-t_r(i))/1000;  %Fs=1000
end
%rrMean=mean(RRinterval);                                                   % comment out to ger RRI mean value
end