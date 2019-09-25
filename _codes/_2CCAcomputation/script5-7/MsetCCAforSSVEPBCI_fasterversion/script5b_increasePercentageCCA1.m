%clear all
%% load variables (non-caffeinated and caffeinated from 5a)
load('/mnt/pd/Kishore_thesis/normalized/beforeCCA1.mat')
load('/mnt/pd/Kishore_thesis/normalized/afterCCA1.mat')

clearvars incpercent
%% computaion of % differences

A=after;
B=before;
I=A-B;

for r=1:numel(A)
    incpercent(r,1) = I(r)/B(r)*100
end
%% Normalization
maxA=max(A);
maxB=max(B);

lA=A./maxA;
lB=B./maxB;


%% Plot
Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%freq={'3Hz' '5 Hz' '10 Hz' '15 Hz' '20 Hz' '25 Hz' '30 Hz'}% 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
%f=categorical(freq);


%{
A=sumDetectallCh;%=featureScaling(hits)
normA = A - min(A(:))
normA = normA ./ max(normA(:))
%}

figure, bar(c,incpercent)
%text(1:length(incpercent),incpercent,num2str(incpercent'),'vert')%,bottom,horiz,center)
xlabel('EEG channel','FontSize', 30), ylabel('% change in SSVEP detection','FontSize', 30), title('Percentage change in SSVEP detection after stimulus'); 
%set(gca,'FontSize',25,'xticklabel',{'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'});
%ylim([-1,1])
       
grid on

%% Save 'inpercent' variable (.mat file) ----Stimulated Channels successfully identified 




