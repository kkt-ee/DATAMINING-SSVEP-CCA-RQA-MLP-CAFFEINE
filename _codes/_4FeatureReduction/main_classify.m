%% STEP 3 : -CLASSIFICATION-                 
%
%  MAIN()
%   Calculates predictor importance of ONE phase (eg. P1/P2/P3)
%   Prequisite: Load the features (Refer README)


%% main fUNCTION : main_classify()

function impPredictors = main_classify(table2classify, classes)
    %% fUNCTION CALL: classify()
    [tc,md1,Mdl,MdlCART,imp1,imp2,imp3,impCART] = classify(table2classify, classes);

    %%
    ip1 = impPredsort_(imp1,tc);
    ip2 = impPredsort_(imp2,md1);
    ip3 = impPredsort_(imp3,Mdl);
    ip4 = impPredsort_(impCART,MdlCART);
    
    impPredictors={ip1{:},ip2{:},ip3{:},ip4{:}};                  % creating cell array of unique predictors
    impPredictors=unique(impPredictors);          % Removing repeating items
    
    %%
    

    % fprintf(' p1 = %f\n p2 = %f\n p3 = %f\n p4 = %f\n',p1,p2,p3,p4)     % if values predictors needed
    %% (-------uncomment 4 lines below ------)
    %fprintf('CART                        : %s\n',p1) 
    %fprintf('Boosted tree                : %s\n',p2)
    %fprintf('Random Forest 1 (curvature) : %s\n',p3)
    %fprintf('Random Forest 2 (CART)      : %s\n',p4)          % if names of predictors needed   

    %impPredictors={p1,p2,p3,p4};                  % creating cell array of unique predictors
    %impPredictors=unique(impPredictors);          % Removing repeating items

    % just to viz (Optional)
    %fprintf("\nImportant Predictors:\n")
    %for i=1:length(impPredictors)
     %   fprintf("\t"+impPredictors{i}+"\n")
    %end
    %% Feature scaling or unity based Normalizaion 
    % Input imp1 imp2 imp3 impCART
    %imp1=featureScaling(imp1);
    %imp2=featureScaling(imp2);
    %imp3=featureScaling(imp3);
    %impCART=featureScaling(impCART);

    %% fUNCTION CALL: viz_classified2()    
    %view(tc,'mode','graph')  % comment out

    %viz_classified2(tc, imp1, 'CART')
    %viz_classified2(md1, imp2, 'Boosted tree')
    %viz_classified2(Mdl, imp3, 'Random Forest 1 (curvature)')
    %viz_classified2(MdlCART, impCART, 'Random Forest 2 (CART)')
end