%% load output variables from script 7A
clear all
load('/mnt/pd/Kishore_thesis/normalized/beforeCCA2.mat')
load('/mnt/pd/Kishore_thesis/normalized/afterCCA2.mat')


%%  Percentage change
A2=after2;
B2=before2;
I2=A2-B2;

for r=1:numel(A2)
    incpercent2(r,1) = I2(r)/B2(r)*100
end

%% normalization
maxA2=max(A2);
maxB2=max(B2);

lA2=A2./maxA2;
lB2=B2./maxB2;


%% plot


figure, bar(incpercent)
xlabel('Photic frequency','FontSize', 30), ylabel('% change in SSVEP detection)','FontSize', 30), title('Percentage change in SSVEP detection after stimulus','FontSize',30); 
set(gca,'FontSize',16,'xticklabel',{'3 Hz' '5 Hz' '10 Hz' '15 Hz' '20 Hz' '25 Hz' '30 Hz'});
%ylim([-1,1])
       
grid on



%% @kishore