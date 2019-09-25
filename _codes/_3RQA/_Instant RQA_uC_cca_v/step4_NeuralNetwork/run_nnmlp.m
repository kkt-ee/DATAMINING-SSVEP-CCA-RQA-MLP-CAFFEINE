%% RUN (RUN 4/4)
% STEP 4 : NEURAL NETWORK
%   a) MLP (Multilayer Perceptron)
%
%   A. USER INPUTS >>
%         xlsxfile        = "________"                % ENTER xlsx filename with "RQA features" (From STEP 2)
%         sheetname       = "________"                % ENTER sheetname of the xlsxfile
%         hiddenNeurons   = [__:__]                   % Set RANGE for number of neurons in hidden layer 
%       
%         CLASS NAMES/  a = "____"                    % ASSUMPTION: Data contains only two classes 
%         CATEGORIES    b = "____"                        ...eg. (Pre-stimulus & Post-stimulus) 
%           
%         impPredictors   = {"___","___",...,"___"}   % ENTER impPredictors obtained from STEP 3: "CLASSIFICATION"
%    
%    B. Calling main fUNCTION call: main_nnmlp() >>
%         Tnnresults= main_nnmlp(xlsxfile,sheetname,hiddenNeurons,a,b,impPredictors)
%
% -----------------------------------------------------------wrapper end---       



clc
clear all
disp("Program executing...")
%% Initializing parameters

load /mnt/pd/_ccaResult/impPredictors.mat
ipdir='/mnt/pd/_ccaResult/_ccaRQA/AB132RQAtables/inxlsx/';
opdir='/mnt/pd/_ccaResult/_ccaANN/';
count=0;

%sheetname='Sheet1';                                             
a = 'A';                                                 
b = 'B'; 
hiddenNeurons = [7:12]; % <<<<<------------------------------------------enter-

whos
%% User Inputs >>
% NOTE: Edit CONSTANTS in main_nnmlp.m if needed (eg.to change training algorithm)

%[ENTER VALUES]
for chx = 2%:22
    for px = 3:7
        fprintf('chx = %d px=%d\n',chx,px); count = count+1;
        xlsxfile=strcat(ipdir,'ABCh',num2str(chx),'Stim',num2str(px),'RAWall6vol.xlsx');  
       
        %% variables
        tempImpPred = impPredictors{count,1}; % <<<<<------------------enter-
        if isempty(tempImpPred) ~= 1
            
            % << calling main() >> 
            Tnnresults = main_nnmlp(xlsxfile,hiddenNeurons,a,b,tempImpPred);
            
            opfname    = strcat(opdir,'Ch',num2str(chx),'Stim',num2str(px),'ANN_op.csv'); % <<<<<---enter-
            writetable(Tnnresults,opfname);  % writing/saving table
        else
            disp('zero predictors...')
        end
        
        clearvars xlsxfile opfname Tnnresults tempImpPred
    end
end



%% OBSERVATIONS: RQA ANN-MLP R-R INTERVAL DATA 
