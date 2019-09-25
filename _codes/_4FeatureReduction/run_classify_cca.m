%% RUN (Run 3/4)    
% STEP 3 : CLASSIFICATION
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% RUN (GUIDE):
%       A. USER INPUTS >>
%          a. [Code gap] [MANUALLY EDIT] the xlsx file obtained from step2 for P1 P2 and P3 
%                      ....SET the data to two classes (eg. before and after stimulus)
%                      ....SAVE as a < new xlsx file >
%          b. [Preq] Manually load the < new xlsx file > to workspace using GUI techniques
%          c. workspaceTableVariable = _____________;   % 
%             classVariableInTable   = '_____';         % Specify the name of the category/class variable in loaded table
%
%       B. Calling main fUNCTION : main_classify >>
%              impPredictors = main_classify(workspaceTableVariable, classVariableInTable)   % Loaded table <subject to change>
%`~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

close all
clear all
disp("Program executing...")
%% USER INPUTS 
%[ENTER VALUE] >>>
ipdir='/mnt/pd/_ccaResult/_ccaRQA/mabfRQAtables/mabfAB_132RQAtables/';
count=0;
%opdir=
%%
for chx = 1%:22
    for px = 2:7
        fprintf('chx = %d px=%d\n',chx,px);
        ipfname=strcat(ipdir,'ABCh',num2str(chx),'Stim',num2str(px),'MABFall6vol.csv');  
        
        workspaceTableVariable = readtable(ipfname);    % < rrisamsampletableS3 > Subject to change [Enter xlsxfile name]
        classVariableInTable = 'LABEL';       % Enter category/class variable name
                        
%%
        % << calling main() >> 
        count = count+1;
        impPredictors{count,1} = main_classify(workspaceTableVariable, classVariableInTable);   % Loaded table <subject to change>
        impPredictors{count,2} = ipfname(43:end);
        disp(impPredictors{count,1})
    end
end






%% OUTPUT : We get Important Predictors from the loaded RQA features' table 
%           ------>>> To plug in this Important Predictors to Neural Nerwork in Step 4 

% OBSERVATIONS (Important Predictors):
%       ---(Pre and Post caffeine Data)
%   Ch 8 :    avg_neighbours
%   Ch 10:    LAM, RECRATE
%   Ch 11:    LAM, RATIO, avg_neighbours
%   Ch 12:    Avg_diag, avg_neighbours
%   Ch 14:    
%   Ch 15:    DET, VMAX, avg_neighbours

