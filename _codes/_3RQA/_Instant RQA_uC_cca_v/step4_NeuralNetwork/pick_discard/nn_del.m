
% The following program is adapted from
%https://in.mathworks.com/help/nnet/examples/crab-classification.html

%clc;
%clear all;
close all;
nntraintool('close')
%%
%actfn = {'tansig','logsig','purelin'};
%errfn = {'sse','crossentropy'};

%%
xlsxfile="../rrisampletable_1.xlsx";
impPredictors={'VMAX','DET','recrate','LAM','avg_neighbours'};
tr = nnmlp(xlsxfile,impPredictors,'P2AS','P2BS');

function tr = nnmlp(xlsxfile,impPredictors,a,b)
[num,txt,~] = xlsread(xlsxfile,'p2'); % read excel data file
specified_class=txt(2:end,1); %read class column(1st)
Index_classA = find(contains(specified_class,a)); %(find index of class A)
Index_classB = find(contains(specified_class,b)); %(find index of class B)

nn_Target=zeros(2,size(specified_class,1));% SPecify class in binary (1,0) form for NN tool box
nn_Target(1,Index_classA)=1;
nn_Target(2,Index_classB)=1;
%%
features = {'recrate', 'DET', 'LMAX', 'ENT', 'LAM', 'TT', 'VMAX', 'RATIO', 'avg_neighbours', 'DIV', 'Avg_diag'};  %all features

for i=1:length(impPredictors)
    idx(i) = find(contains(features,impPredictors{i}));                     % idx will store the index of impPredictors
    nn_input(:,i)=num(:,idx(i));
end

nn_input=nn_input';
%%
%nn_input=[num(:,1) num(:,2) num(:,3) num(:,4)]'; % select feature in column 1,2,3,4

setdemorandstream(491218382)  % Random seed
net = patternnet(11,'trainbr','sse')%10 hiden layers

net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

%view(net) %View the NN structure
[net,tr] = train(net,nn_input,nn_Target); % NN start training by randomly dividing data into training and test
%nntraintool  %open NN GUI
plotperform(tr)  %performance graph


%% Test classifier with test data
testX = nn_input(:,tr.testInd);
testT = nn_Target(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY);

%%
vX = nn_input(:,tr.valInd);
vT = nn_Target(:,tr.valInd);
vY = net(vX);

trainX = nn_input(:,tr.trainInd);
trainT = nn_Target(:,tr.trainInd);
trainY = net(trainX);

%plotregression(trTarg, trOut, 'Train', vTarg, vOut, 'Validation', tsTarg, tsOut, 'Testing')

%% Plotting and printing
plotconfusion(testT,testY)  %Plot confusion matrix 

[c,cm] = confusion(trainT,trainY);   % TRAIN 
fprintf('[TRAIN]    Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[TRAIN]    Percentage Incorrect Classification : %f%%\n', 100*c);

%plotconfusion(testT,testY)%Plot confusion matrix
[c,cm] = confusion(vT,vY); % VALIDATE
fprintf('[VALIDATE] Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[VALIDATE] Percentage Incorrect Classification : %f%%\n', 100*c);

%plotconfusion(testT,testY)%Plot confusion matrix
[c,cm] = confusion(testT,testY); % TEST
fprintf('[TEST]     Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[TEST]     Percentage Incorrect Classification : %f%%\n', 100*c);

plotroc(testT,testY)

allX = nn_input;
allT = nn_Target;
allY = net(allX);
[c,cm] = confusion(allT,allY); % TEST
fprintf('[ALL]      Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[ALL]      Percentage Incorrect Classification : %f%%\n', 100*c);

end
