
%% 1.
close all, clear all, clc

% Neuron weights
w=[4 -2];

% Neurn bias
b= -3;

% Activation function
func='tansig';
% func = 'purelin';
% func = 'hardlim';
% func = 'logsig';
 
% Define input vector
p=[2 3];

% Calculate neuron output                                                           *Neuron output*
activation_potential = p * w'+ b;
neuron_output = feval(func,activation_potential);

% Plot neuron output over the range of inputs
[p1 p2] = meshgrid(-10:.25:10);
z=feval(func,[p1(:) p2(:)]*w'+b);
z=reshape(z,length(p1),length(p2));
plot3(p1,p2,z)
grid on
xlabel('Input 1')
ylabel('Input 2')
zlabel('Neuron output')






%% 2.
close all, clear all, clc, format compact

inputs = [1:6]'  %input vector 6 dimensionsional pattern
outputs=[1:2]' % corresponding target output vector

% Create a network                                                              *Define an  custom network*
net = network(...
    1,        ... % numInputs,          number of inputs,
    2,        ... % numLayers,          number of layers
    [1; 0],   ... % biasConnect,        numLayers-by-1 Boolean vector,
    [1; 0],   ... % inputConnect,       numLayers-by-numInputs Boolean matrix,
    [0 0;1 0],... % layerConnect,       numLayers-by-numLayers Boolean matrix
    [0 1]     ... % outputConnect,      1-by-numLayers Boolean vector
    );

% view network structure
view(net);

% number of hidden layer neurons
net.layers{1}.size=5;

% hidden layer transfer function
net.layers{1}.transferFcn = 'logsig';
view(net);

% configure network
net = configure(net,inputs,outputs);
view(net);

%% train net and calculate neuron output
% initial network response without training
initial_output=net(inputs)

% network training
net.trainFcn = 'trainlm';
net.performFcn = 'mse';
net = train(net,inputs,outputs);

% network response  after training
final_output = net(inputs)






%% 3. CLASSIFICATION OF A LINEARLY SEPARABLE DATA WITH A PERCEPTRON                       *CLASSIFICATION*
% PROBLEM DESCRIPTION: Two clusters of data, belonging to two classes are
% defined in a 2 dimensional input space. Classes are linearly separable.
% The task is to construct a perceptron for the classification of data.

%% Define input and output data

close all, clear all, clc

% number of samples of each class
N = 20;
% define input and outputs
offset = 5;                              % offset for second class
x = [randn(2,N) randn(2,N)+offset];      % inputs
y = [zeros(1,N) ones(1,N)];
 
% Plot input samples with PLOTPV (Plot perceptron input/target vectors)
figure(1)
plotpv(x,y);

%% Create and train perceptron

net = perceptron;
net = train(net,x,y);
view(net);

%% Plot decision boundary

figure(1)
plotpc(net.IW{1},net.b{1});







%% 4. CLASSIFICATION OF A 4 CLASS PROBLEM WITH A PERCEPTRON
% PROBLEM DESCRIPTION: Perceptron network with 2-inputs and 2-outputs is
% trained to classify input vectors into 4 categories

%% Define data

close all, clear all, clc

% number of samples of each class
K=30;

% define classes
q=.6;
A=[rand(1,K)-q; rand(1,K)+q];
B=[rand(1,K)+q; rand(1,K)+q];
C=[rand(1,K)+q; rand(1,K)-q];
D=[rand(1,K)-q; rand(1,K)-q];
% plot classes
plot(A(1,:),A(2,:),'bs')
hold on
grid on
plot(B(1,:),B(2,:),'r+')
plot(C(1,:),C(2,:),'go')
plot(D(1,:),D(2,:),'m*')
% text labels for classes
text(.5-q,.5+2*q,'Class A')
text(.5+q,.5+2*q,'Class B')
text(.5+q,.5-2*q,'Class C')
text(.5-q,.5-2*q,'Class D')
% define output coding for classes
a = [0 1]';
b = [1 1]';
c = [1 0]';
d = [0 0]';
% % Why this coding doesn't work?
% a = [0 0]';
% b = [1 1]';
% d = [0 1]';
% c = [1 0]';
% % Why this coding doesn't work?
% a = [0 1]';
% b = [1 1]';
% d = [1 0]';
% c = [0 1]';