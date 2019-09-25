%Poicare Plot
%data = load('Bhang_RRI.lvm'); 


errors = 'errors:\n';
for i = 1:length(RRIvector)
    t=RRIvector{i,1}
    try
        data=RRIvector{i,2}{1,1};
        %t=RRIvector{i,1}
        poincare(data,t);
    catch
        errors=strcat(errors,' ',t);

end
end
function [SD1 SD2 SDRR]=poincare(data,t)

xp=data;

x=xp(1:end-1,:);
y=xp(2:end,:);

% CALCULATING CENTROID
xc = mean(x);
yc = mean(y);

% EQUATION OF "LINE OF IDENTITY" AND ITS PERPENDICU;AR FROM CENTROID
y1=tan(pi/4)*(x);
y2=tan(3*pi/4)*(x)+(xc+yc);

for i = 1:length(data)-1
    d1(i) = abs( (x(i)-xc)-(y(i)-yc) )/sqrt(2);
    d2(i) = abs( (x(i)-xc)+(y(i)-yc) )/sqrt(2);
end

SD1=std(d1);  % minor diagonal
SD2=std(d2);  % major diagonal

SDRR=sqrt(SD1^2+SD2^2)/sqrt(2);

%%
r1=SD1;%/2;
r2=SD2;%/2;

dx1=xc+r2*cos(pi/4);
dy1=yc+r2*sin(pi/4);
dx2=xc-r2*cos(pi/4);
dy2=yc-r2*cos(pi/4);

dx3=xc-r1*cos(pi/4);
dy3=yc+r1*sin(pi/4);
dx4=xc+r1*cos(pi/4);
dy4=yc-r1*sin(pi/4);
%%
fig = figure();
set(fig,'Position',[30 20 600 600])

scatter(x,y,'g.')                                % scatter plot
title(t)  
xlabel('RRn')
ylabel('RRn+1')
xlim([ min(x), max(x)])
ylim([ min(x), max(y)])
hold on

plot(y1,x,'b');                                % line of Identity
%plot(y2,x,'--b');

%plot(dx1,dy1,'rx')
%plot(dx2,dy2,'rx')
%plot(dx3,dy3,'r*')
%plot(dx4,dy4,'r*')
%line([dx1 dx2], [dy1 dy2],'r')
plot([dx1 dx2], [dy1 dy2],'r','LineWidth',1.5)  % SD
plot([dx3 dx4], [dy3 dy4],'r','LineWidth',3)

plot(xc,yc,'bo')%,'LineStyle','-.')
ellipse(2*SD2,2*SD1,pi/4,xc,yc,'g')

legend('R-R Intervals','Line of Identity','SD2','SD1','Center','Fitted ellipse')
hold off
%%
folname='/home/k/workbench/MTech_Research/SIGNALPROCESSING/RQA_underConstruction/Resutlts/Poincare/';
figfileName=strcat(t,'_Poincare')%remove

saveas(fig, fullfile(folname, figfileName), 'jpeg');  %remove
close all
end
%{
function figsave(figr,titl)
%% saving figure
folname="/home/k/workbench/MTech_Research/SIGNALPROCESSING/RQA_underConstruction/Resutlts/Poincare";
figfileName=strcat(titl,'_Poincare');%remove
saveas(figr, fullfile(folname, figfileName), 'jpeg');  %remove
end
%}