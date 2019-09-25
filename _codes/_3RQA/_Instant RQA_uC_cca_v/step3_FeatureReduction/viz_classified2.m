%% STEP 3 : -CLASSIFICATION- 
%
% SUPPORTING()
%       % for vizualization of classification results 

%%
%{
%% VISUALIZE predictorImportance (i.e. the important features)
function viz_classifed(tc,md1,Mdl,MdlCART,imp1,imp2,imp3,impCART)

%% viz CART
% Optional

view(tc,'mode','graph')

figure;
bar(imp1);                                     % imp1
title('Predictor Importance E stimates')
ylabel('Estimates')
xlabel('Predictors')
h=gca;
h.XTickLabel = tc.PredictorNames;              % tc
h.XTickLabelRotation=45;
h.TickLabelInterpreter='none';

%% viz Boosted tree
figure;
bar(imp2);                                     % imp2
title('Predictor Importance E stimates')       
ylabel('Estimates')
xlabel('Predictors')
h=gca;
h.XTickLabel = md1.PredictorNames;             % md1
h.XTickLabelRotation=45;
h.TickLabelInterpreter='none';

%% viz Random Forest
figure;
bar(imp3);                                     % imp3
title('Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;             % Mdl
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';

%% viz Random Forest
figure;
bar(impCART);                                  %% impCART
title('Standard CART');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = MdlCART.PredictorNames;         % MdlCART
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';

end
%}
%% supporting fUNCTION : viz_classified2()
function viz_classified2(classificationtree, predictors,plottitle)

%disp(plottitle)
figure;
bar(predictors);                                          % predictors
title(plottitle);
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = classificationtree.PredictorNames;         % classificationtree
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';
end