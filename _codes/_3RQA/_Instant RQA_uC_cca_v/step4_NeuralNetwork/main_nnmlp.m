%% [MAIN] fn
% STEP 4 : -NEURAL NETWORK- 
%                  ...MLP
%
%     <TODO :tRY TO RANDOMIZE THE NEURON NOS TOO>

% main fUNCTION : main_nnmlp() : Checks NN for all combinations of
                                        ....CONSTANTS (LINE 19-22)

function Tnnresults= main_nnmlp(xlsxfile,hiddenNeurons,a,b,impPredictors)
%clc;
%clear all;
close all;
nntraintool('close')
%% CONSTANTS !!!!!

%impPredictors={'VMAX','DET','recrate','LAM','avg_neighbours'};
TRAINfn = {'trainlm','trainbfg'};
ACTfn1 = {'tansig','logsig'};
ACTfn2 = {'tansig','logsig','purelin','softmax'};
ERRfn = {'sse','crossentropy'};

% -------TEMP---------
%ACTfn1 = {'tansig'};      % Comment out after crossvalidatiom (and uncomment line 20 and 21)
%ACTfn2 = {'purelin'};     %                             -do-
%ERRfn = {'sse'};          %                             -do-
% -------TEMP---------


%% prerun  
T=nnparameters(TRAINfn,ACTfn1,ACTfn2,ERRfn);        % creating the nnparameter table for input of 'NNparam' to nnmlp:  fUNCTION CALL: nnparameters()
[Ttotalrows ,c]=size(T);                            % Counting total number of columns
ridx = [1:Ttotalrows];                              % ridx is the index if table rows
ridx = ridx(randperm(length(ridx)));                % SHUFFLING the row indexes for random choosing a row from 'Table T'


%% Training one by one and looking for the better neural network 
Tnnresults=table();                                                         % Tnnresults: will store the trained NNs
COUNT=0;
for k=hiddenNeurons(1):hiddenNeurons(end)
%k=12;
for i=1:numel(ridx)
    COUNT=COUNT+1;
    
    NNparam = T(ridx(i),:);
    %Tnnresults=[Tnnresults;NNparam]
    
    [PerfTrain, PerfTest, PerfValidate,PerfTotal] = nnmlp(xlsxfile,impPredictors,a,b,NNparam,k);        % fUNCTION call: nnmlp()
    
    %CHECK
    %writing results to a table
    x=NNparam;
    xa={PerfTrain,PerfValidate,PerfTest,PerfTotal,k,COUNT};
    x=[x,xa];
    Tnnresults=[Tnnresults;x] 
        
    %if (PerfTrain>90 && (PerfTest>90 || PerfValidate>90))
     %   break
    %end
    
end
end
Tnnresults.Properties.VariableNames = {'trainfn','actfn1','actfn2','errfn','PerfTrain', 'PerfTest', 'PerfValidate','PerfTotal','Neurons','Slno'};

end



