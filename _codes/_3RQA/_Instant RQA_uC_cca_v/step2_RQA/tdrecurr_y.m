function x = tdrecurr_y(cbuffer,thrhd,filename)%,resultdir)                                     % remove 'filename'
%This program produces a threshold recurrence plot of the, possibly multivariate,
%data set. That means, for each point in the data set it looks for all 
%points, such that the distance between these two points is smaller 
%than a given size in a given embedding space. 
%Author: Hui Yang
%Affiliation: 
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com
%
%input:
%cbuffer: the recurrence matrix     
%thrhd: threshold value for the recurrence matrix
%
%output:
%x - Vector containing the coordinate of recurrence points.

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

global resultdir
%%
[m,n] = size(cbuffer);
[i,j] = find(cbuffer<=thrhd);
x=[i j];


%{ 
%TROUBLESHOOT START

%% (1)
for i=1:100
thrhd=i*.01;
[m,n] = size(cbuffer);
[i,j] = find(cbuffer<=thrhd);
x=[i j];
     
    f=figure;%('Position',[100 100 550 400]);                                 %remove 'f='
    plot(x(:,1),x(:,2),'k.','MarkerSize',2);
    xlim([0,m]);
    ylim([0,n]);
    xlabel('Time Index','FontSize',10,'FontWeight','bold');
    ylabel('Time Index','FontSize',10,'FontWeight','bold');
    title('Recurrence Plot','FontSize',10,'FontWeight','bold');
    get(gcf,'CurrentAxes');
    set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
    pause
    close
end 

 
%% -------(1)--or--
[m,n] = size(g);
[i,j] = find(g<=thrhd);
x=[i j];


% TROUBLESHOOT END
%}
%%
if nargout == 0
    %%
    f=figure;%('Position',[100 100 550 400]);                                 %remove 'f='
    plot(x(:,1),x(:,2),'k.','MarkerSize',2);
    xlim([0,m]);
    ylim([0,n]);
    xlabel('Time index','FontSize',30,'FontWeight','bold');
    ylabel('Time index','FontSize',30,'FontWeight','bold');
    title('Recurrence Plot','FontSize',20,'FontWeight','bold');
    get(gcf,'CurrentAxes');
    set(gca,'LineWidth',2,'FontSize',20,'FontWeight','bold');
    grid on;
    
    %% saving to file
    filename=strcat(filename,' BWrecurrencePlot'); %remove
    saveas(f, fullfile(resultdir, filename), 'jpeg');             %remove 
end
