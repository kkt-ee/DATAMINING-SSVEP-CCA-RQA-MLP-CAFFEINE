% The following program is adapted from
%https://in.mathworks.com/help/nnet/examples/crab-classification.html

clc;
clear all;
close all;

[num,txt,~] = xlsread("p1.xlsx"); % read excel data file
specified_class=txt(2:end,1); %read class column(1st)
Index_classA = find(contains(specified_class,'a')); %(find index of class A)
Index_classB = find(contains(specified_class,'b')); %(find index of class B)

nn_Target=zeros(2,size(specified_class,1));% SPecify class in binary (1,0) form for NN tool box
nn_Target(1,Index_classA)=1;
nn_Target(2,Index_classB)=1;

nn_input=[num(:,1) num(:,2) num(:,3) num(:,4)]'; % select feature in column 1,2,3,4


setdemorandstream(491218382)  % Random seed
net = patternnet(10);%10 hiden layers
view(net) %View the NN structure
[net,tr] = train(net,nn_input,nn_Target); % NN start training by randomly dividing data into training and test
nntraintool  %open NN GUI
plotperform(tr)  %performance graph

%% Test classifier with test data
testX = nn_input(:,tr.testInd);
testT = nn_Target(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY)

plotconfusion(testT,testY)%Plot confusion matrix
[c,cm] = confusion(testT,testY) 

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

plotroc(testT,testY)