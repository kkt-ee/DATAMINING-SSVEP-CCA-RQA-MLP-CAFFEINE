%% RUN (RUN 2/4)
% STEP 2 : [RQA] R-R Intervals on Smokers data (Before and after smoking)
% RQA_v2 : v2 [computes for all signal files]
%        .......(computes for entire dataset)
%% %% [ README FIRST !!! ]  RUN (GUIDE)
%     A. USER Input >> 
%            [PREREQUISITE]- lOAD WORKSPACE WITH THE 'RRI DATASET'(.mat file if saved) (calculated from --main_rri.m) 
%            Tablefilename  = '_____________'; % Enter 'RQA statistics' filename for the file to be created
%            figsavefolname = '_____________'; % Enter the folder path for saving plot figures
%
%     B. calling main fUNCTION >> 
%            RQAstatistics = main_RQA(RRIvector,figsavefolname)
%      
%     C. OTHER COMMANDS >>
%            Tn9ew = CreateTable(RQAstatistics); % call CreateTable() to create a RQAstatistics Table
%            writetable(Tnew,Tablefilename);    % Write the table to file Tablefilename
%
%     NOTE: To pause after each execution: comment out line 35 of main_RQA.m  

clear all
global resultdir
%global count

% [PREREQUISITE] lOAD WORKSPACE WITH THE 'RRI DATASET'(.mat file if saved) (calculated from --main_rri.m) 
%% 1. [ EDIT AND RUN ] >>>>ENTER VALUE<<<<
load /mnt/pd/vars/sigVecVectorB1-6forRQAselectedch.mat
%savefilename='deldel'
sigs=newsigVecVector{5}
%sig=rrv{1,2}{1};
x=sigs;
resultdir = '/mnt/pd/vars/temp_ch8RQAres';

%ssvep=ssvep(1,:);
%% 2. Calling main() >> 
%RQAstatistics = main_RQA(RRIvector,figsavefolname)
RQAstat = main_RQA(x)%,figsavefolname)

%% extra lines delete
%{
clear all

load /mnt/pd/vars/ssvepv3d1A.mat 
resultdir = '/mnt/pd/RGFT/resultsv3d1A';

RQAstat = main_RQA(ssvep)%,figsavefolname)

%}

%% [ EDIT AND RUN ] << Creating Table >>
%Tablefilename = 'C:\Users\kishore\Desktop\RQA-example\v2d1A_1Hz_RQA.csv'; 
Tablefilename = '/mnt/pd/vars/temp_ch8RQAres/RQAch14B.csv';

% remove below two***
Tnew=CreateTable(RQAstat);                   % fUNCTION CALL : CreateTable()
writetable(Tnew,Tablefilename);                    % Writing table to file 'Tablefilename'












%runrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrunrun
% ...
% ...
% make README file ...

% !!!
% Errors Last run 28-May-18:
% P1AS11 P1BS10 P1BS7 P1BS8 P2BS12 P3AS12




%% OUTPUT: Table if RQA features ------->>> (Code gap) Manual Process the table (README STEP 3) 
%  Processed table ---->>> Next: 
%           STEP 3: (a) t-test, 
%                   (b) feature reduction (classification)   