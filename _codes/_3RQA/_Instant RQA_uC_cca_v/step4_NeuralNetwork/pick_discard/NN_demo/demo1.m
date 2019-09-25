%% Create and train and MLP to learn and evaluate the following function
% $$ y=(x^2-6.5)/(x^2+6.5) for -10<x<10 $$
%
% *5 Steps*
%% 1. Generate input-output training data 
i=1;
%{
for x=-10:0.5:10
    y=(x^2-6.5)/(x^2+6.5);
    i=i+1;
end
%}
x=-10:0.5:10;
y=(x.^2-6.5)./(x.^2+6.5);

%% 2. Create a MLP network
net=newff(x,y,5);
%net=newff(x,y,5,{'tansig','tansig'},'traingd')

%% 3. Train the MLP

net.trainParam.show = 500;
net.trainParam.lr = .01;
net.trainParam.epoch = 10000;
net.trainparam.goal = 0.001;

net=train(net,x,y);

%% 4. Generate test data
tx=-10:0.2:10;
ty=(tx.^2-6.5)./(tx.^2+6.5);

%% 5. Simulate network

yy=sim(net,tx);
plot(tx,yy,'r');
hold on;
plot(tx,ty,'g-.')
grid on;
ylabel('output --->'), xlabel('input --->');



%--------------------------------------------------------------------------
% Note: The network created is able to approximate the function to resanably good
% extent, although it was not trained enough, that is error goal was not
% attained
%
%
% Source:
% Book - Matlab and its applications in Engineering
% Authors - Raj Kumar Bansal, Ashok Kumar Goel, Manoj Kumar Sharma
% Chapter - MATLAB Applications in Neural Networks
%
% --- Kishore, NIT Rourkela, date: May-2018