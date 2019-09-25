%% SSVEP: program segment 7 (channel reduction done)
%{
   Script creates a 8ch 4D variable from the 22ch_maSSVEP-4D 
   author @kishore
%}
clear all
%%
load /mnt/pd/vars/SSVEPdataB1-6.mat
sig=SSVEPdata; 

% for example
% impch=[1 8 9 10 11 12 14 15];    % set B
% impch=[  8,  10,11,12,14,15,13]; % set A
% impch is a varibles containing the index of important channels (from setA
% and B).further analysis is carried out for both non caffeinated and
% caffeinated group

impch =[9,12,13,18,20,22]; % selected channels <--------- enter important channel obtained at the end of script 5
% Taking union of setA and setB



for p=1:7
    % photic
    for v=1:6
        % volunteer
        for c=1:6
            % channel
            idx=impch(c);
            newsig(c,:,v,p)=sig(idx,:,v,p);
        end
    end
end

whos
%% save
filename='/mnt/pd/vars/SSVEP_6ch_B1-6.mat';
save(filename,'newsig');


