clc;
clear all;
close all;
[x,t] = crab_dataset;
setdemorandstream(491218382) % Random seed
net = patternnet(10);%10 hiden layers
view(net) %View the NN structure
[net,tr] = train(net,x,t);% NN start training by randomly dividing data into training and test
nntraintool %open NN GUI
plotperform(tr) %performance graph

%% Test classifier with test data
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY)
plotconfusion(testT,testY)
[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

plotroc(testT,testY)