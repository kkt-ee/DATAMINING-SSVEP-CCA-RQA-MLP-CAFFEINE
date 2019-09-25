
%load /mnt/pd/vars/dir1_matfiles_raw/ssvepv1d1B.mat

%{ 
%% 2D to 3D conversion
for i=1:length(ssvep)
    tempsig=ssvep{i};
    %whos 
    %pause
    
    DEssvep(:,:,i)=tempsig;
end
%}

%whos
%sig=ssvep{1};
%plotEEG(sig)




%% plotEEG main function--
function plotEEG(data)

m = max(max(abs(data)));
numChannels = size(data,2);

plot(data + (ones(size(data,1),1)*(1:numChannels) - 1) * m * 1.5);
end
