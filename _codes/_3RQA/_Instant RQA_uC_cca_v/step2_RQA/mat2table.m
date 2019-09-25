% @author: kishore
% This program will run to convert .mat files to a table (.csv file)
% after the 
%% make load var name
% The mat files are stored by names:
%       sig1HzRQAstatistics.mat
%       sig5HzRQAstatistics.mat
%       sig10HzRQAstatistics.mat
%       sig15HzRQAstatistics.mat
%       sig20HzRQAstatistics.mat
%       sig25HzRQAstatistics.mat
%       sig30HzRQAstatistics.mat
% Now next:
%     0. generate .mat filename
%     1. load a .mat file 
%     2. add a Montage column in the loaded variable RQA statistics
%                column1: MONTAGES    column2:data
%     3. CreateTable

clear all
signame= 'v1d1B'   % >>>Enter value<<<
phf={'1' '5' '10' '15' '20' '25' '30'};
MONTAGES={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2' 'ECG'};

%% 0.
% generating matfilepath name e.g. /mnt/pd/RGFT/resultsigv2d1A/vars/sig1HzRQAstatistics.mat 
% /mnt/pd/RGFT/resultsigv2d1A/vars/ 
   matfilepathpart1= '/mnt/pd/RGFT/resultsig';
   matfilepathpart2= signame;
   matfilepathpart3= '/vars/';
matfilepath=strcat(matfilepathpart1,matfilepathpart2,matfilepathpart3);
clearvars matfilepathpart1 matfilepathpart2 matfilepathpart3

% sig1HzRQAstatistics.mat
   matfilepart1='sig';
   matfilepart3='HzRQAstatistics.mat';

% table file   
    tabstrpart1= '/mnt/pd/RGFT/TableRQA';
    tabstrpart3= 'Hz';
    tabstrpart5= '.csv';
    
   
%%
for i=1:7
    matfilepart2=phf{i};
    pause % comment out
    matfile=strcat(matfilepart1,matfilepart2,matfilepart3);
    matfile=fullfile(matfilepath,matfile);
% complete path of file generated

    %% 1.
    %load /mnt/pd/RGFT/resultsigv2d1A/vars/sig1HzRQAstatistics.mat
    load(matfile)
    clearvars matfile %matfilepart1 matfilepart3
    %% 2.
    RQAstatistics(:,2)=RQAstatistics;
    RQAstatistics(:,1)=MONTAGES'

    %% '/mnt/pd/RGFT/TableRQA' + 1 + 'Hz' + v2d1A + '.csv'
    
    tabstrpart2= matfilepart2;
    tabstrpart4= signame;   %signame 
        
    %Tablefilename = '/mnt/pd/RGFT/TableRQA1Hzv2d1A.csv';
    Tablefilename = strcat(tabstrpart1,tabstrpart2,tabstrpart3,tabstrpart4,tabstrpart5);
    
    Tnew=CreateTable(RQAstatistics);                   % fUNCTION CALL : CreateTable()
    writetable(Tnew,Tablefilename);                    % Writing table to file 'Tablefilename'
end
clear all