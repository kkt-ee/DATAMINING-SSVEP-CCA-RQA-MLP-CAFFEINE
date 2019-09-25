%% STEP 3 : -CLASSIFICATION-
%
%  CORE() 
%   CLASSIFICATION (FOR IMPORTANT FEATURES)
%   The table of RQA features is obtained from step 2 


%% core fUNCTION : classify()
function [tc,md1,Mdl,MdlCART,imp1,imp2,imp3,impCART] = classify(table2classify,class)
    %% 1. CART
    tc=fitctree(table2classify,class,'Prune','on');
    imp1=predictorImportance(tc);
    
    
    %% 2. Boosted classification tree
    md1 = fitcensemble(table2classify,class);
    imp2 = predictorImportance(md1);

    %% 3a. Random forest (TreeBagger - method 1)
    Mdl = TreeBagger(200,table2classify,class,'Surrogate','on',...
        'PredictorSelection','curvature','OOBPredictorImportance','on');
    imp3 = Mdl.OOBPermutedPredictorDeltaError;

    %% 3b. Random forest (TreeBagger - method 2)
    MdlCART = TreeBagger(200,table2classify,class,'Method','classification','Surrogate','on',...
        'OOBPredictorImportance','on');
    impCART = MdlCART.OOBPermutedPredictorDeltaError;

end
