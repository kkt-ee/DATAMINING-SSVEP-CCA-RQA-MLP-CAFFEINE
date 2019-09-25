%% fUNCTION nnrbf (Test 1 rbf NN)
% Passing one row of parameters from table training and testing 1 NN

% xlsfile       : It is the Features file
% sheetname     : Sheet name of xlsfile
% impPredictors : Obtained from STEP 3 (classification)
% a,b           : Two classes (Pre stimulus & Post stimulus)
% NNparam       : Input parameters for Neural Network
% Neurons       : No of neurons in hidden layer


%% User Inputs
clear all
xlsxfile="rrisampletable_1.xlsx";
sheetname='p3';
hiddenNeurons = [8:12];
a = 'P3AS';
b = 'P3BS';
%impPredictors={'VMAX','DET','recrate','LAM','avg_neighbours'};
impPredictors={'RATIO','recrate'};



%function [PerfTrain, PerfTest, PerfValidate] = nnrbf(xlsxfile,sheetname,impPredictors,a,b,NNparam,Neurons)
%% testing
%{
xlsxfile
sheetname
impPredictors
a
b
NNparam
Neurons
%}
close all;
nntraintool('close')
%% creating Input and Target
[num,txt,~] = xlsread(xlsxfile,sheetname);              % read excel data file
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

nn_input=nn_input';         % Transpose for row wise arrangement
%% sepatating train and test from Input (Random)
% 1. Choose no of cols to choose from each class (eg. 2 cols from 'class a')
% 2. Next: Choose which cols to choose trom each class (eg. column no. 4, 8 from 'class a')
[r col]=size(nn_input);                      % Calculating no of columns of entire data (No. of cols = No. of subjects)(No. of rows = No of impPredictors)
testcolnos=0.25*col;                         % Caluclating No. of columns for testing (25%)
testcolnos=ceil(testcolnos)                  % Roofing the value to remove decimal places (testcols: No. of test items)
col
data_a=nn_input(:,1:col/2);             % splitting 'class a'
data_b=nn_input(:,col/2+1:col);         % splitting 'class b'

sizeeachclass=numel(data_a(1,:));       % size of each class
randomn=randperm(testcolnos-1,1);       % For a random selection from a class (generating no. for no of cols to select)
%Choose n cols from data_a
%Choose testcolnos-n cols from data_b
test1idx = randperm(sizeeachclass,randomn);   % selecting random indexes of 'randomn' nos. of from the total columns of each class (Index to be used for choosing cols.)
%test=




%% Creating NEURAL NET
%nn_input=[num(:,1) num(:,2) num(:,3) num(:,4)]'; % select feature in column 1,2,3,4

setdemorandstream(491218382)                 % Random seed

%trainfn=NNparam.trainfn{1,1} %remove
%errfn=NNparam.errfn{1,1};    %remove

%{
Create a rbf network
net = newrb(P,T,goal,spread,MN,DF) takes two of these arguments,
        P       R-by-Q matrix of Q input vectors
        T       S-by-Q matrix of Q target class vectors
        goal    Mean squared error goal (default = 0.0)
        spread  Spread of radial basis functions (default = 1.0)
        MN      Maximum number of neurons (default is Q)
        DF      Number of neurons to add between displays (default = 25)
%}



%net = patternnet(Neurons,NNparam.trainfn{1,1},NNparam.errfn{1,1});      % 'Neuron' hiden layers
[net tr] = newrb(nn_input,nn_Target,0.001,.2,25,2); 
%%
actfn2={'softmax', 'purelin'};
net.layers{2}.transferFcn=actfn2{1,1};%NNparam.actfn2{1,1};
errfn={'crossentropy','sse'}
net.performFcn=errfn{1,1};
%net.divideParam.trainRatio = 70/100;
%net.divideParam.valRatio = 15/100;
%net.divideParam.testRatio = 15/100;
%%
view(net)                                   % View the NN structure
%[net,tr] = train(net,nn_input,nn_Target);   % NN start training by randomly dividing data into training and test
%nntraintool                                 % open NN GUI
%plotperform(tr)                             % performance graph

%% Test classifier with test data && Plotting and printing
testX = nn_input(:,tr.testInd);
testT = nn_Target(:,tr.testInd);
testY = net(testX);
%%
testIndices = vec2ind(testY);

vX = nn_input(:,tr.valInd);
vT = nn_Target(:,tr.valInd);
vY = net(vX);

trainX = nn_input(:,tr.trainInd);
trainT = nn_Target(:,tr.trainInd);
trainY = net(trainX);

plotconfusion(testT,testY)  %Plot confusion matrix 

[c,cm] = confusion(trainT,trainY);   % TRAIN 
fprintf('[TRAIN]    Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[TRAIN]    Percentage Incorrect Classification : %f%%\n', 100*c);
PerfTrain=100*(1-c);

%plotconfusion(testT,testY)%Plot confusion matrix
[c,cm] = confusion(vT,vY); % VALIDATE
fprintf('[VALIDATE] Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[VALIDATE] Percentage Incorrect Classification : %f%%\n', 100*c);
PerfValidate=100*(1-c);

%plotconfusion(testT,testY)%Plot confusion matrix
[c,cm] = confusion(testT,testY); % TEST
fprintf('[TEST]     Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('[TEST]     Percentage Incorrect Classification : %f%%\n', 100*c);
PerfTest=100*(1-c);

plotroc(testT,testY)

%end
