
%% comment this segment after first run to save addional computing
clear all
load /root/_workfinish/KISHORE-mtechPD_28May2019_ALLData/vars/mabfSSVEPdataA1-6_w40.mat
categ='M';

%% change values and keep running 
vx=3;   % <<----enter volunteer no. ( temp constant )
chx=22; % <<----enter channel no.( temp constant )
phx=7;  % <<----enter photic no.

t(1)=0;
for i = 1:1:5119
    t(i+1)=i/256;
end
sig(:,1)=t';
sig(:,2) = mabfSSVEPdata(chx,:,vx,phx)'; 

sig
%% 2.4. SAVING (USER INPUT >>> and RUN)  {cell array} 'ssvep' variable to .mat
%       e.g. rrssvep01d1A.xlsx : d1 v2 A
savepath  = '/root/Downloads/lvmsforPSD/';   %refer RQA for savin 

fname1=strcat(categ,'_O2_v3_',num2str(phx),'.csv');
fname2=strcat(categ,'_O2_v3_',num2str(phx),'.lvm');
pathf1=fullfile(savepath, fname1)
pathf2=fullfile(savepath, fname2)

%%

%csvwrite(pathf1,sig)
%csvwrite(pathf2,sig)


