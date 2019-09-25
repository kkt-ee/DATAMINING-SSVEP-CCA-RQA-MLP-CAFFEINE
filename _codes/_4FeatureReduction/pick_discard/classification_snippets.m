%% CART
tc=fitctree(rrisampletable1S3,'Name')
view(tc,'mode','graph')

imp=predictorImportance(tc)
%% visualize Predictor importance
figure;
bar(imp);
title('Predictor Importance E stimates')
ylabel('Estimates')
xlabel('Predictors')
h=gca;
h.XTickLabel = tc.PredictorNames;
h.XTickLabelRotation=45;
h.TickLabelInterpreter='none';

%% Boosted classification tree
md1 = fitcensemble(rrisampletable1S3,'Name')
impb = predictorImportance(md1)


%% Random forest

Mdl = TreeBagger(100,rrisampletable1S3,'Name','Surrogate','on',...
    'PredictorSelection','curvature','OOBPredictorImportance','on');
%%
impr = Mdl.OOBPermutedPredictorDeltaError;
%impr = Mdl.ComputeOOBPredictorImportance


figure;
bar(impr);
title('Curvature Test');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';


%%
MdlCART = TreeBagger(100,rrisampletable1S3,'Name','Method','classification','Surrogate','on',...
    'OOBPredictorImportance','on');
%%
impCART = MdlCART.OOBPermutedPredictorDeltaError;

figure;
bar(impCART);
title('Standard CART');
ylabel('Predictor importance estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';
