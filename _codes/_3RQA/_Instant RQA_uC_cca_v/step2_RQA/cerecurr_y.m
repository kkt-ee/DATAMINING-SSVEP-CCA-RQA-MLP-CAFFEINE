function buffer = cerecurr_y(signal,filename)%,resultdir)                               % remove 'filename'
%This program produces a recurrence plot of the, possibly multivariate,
%data set. That means, for each point in the data set it looks for all 
%points, such that the distance between these two points is smaller 
%than a given size in a given embedding space. 

%Author: Hui Yang
%Affiliation: 
       %%The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com

%input:
%signal: input time series     
%dim - embedded dimension 	1
%tau - delay of the vectors 	1

%output:
%buffer - Matrix containing the pair distances.

%example:
%t=sin(-pi:pi/100:10*pi);
%cerecurr_y(t,2,1);

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

global resultdir

Y = signal;

len = length(signal);
N = len;

buffer=zeros(N);

%h = waitbar(0,'Please wait...');
for i=1:N
    %waitbar(i/N);
    x0=i;
    for j=i:N
        y0=j;
        % Calculate the euclidean distance
        distance = norm(Y(i,:)-Y(j,:));
        % Store the minimum distance between the two points
        buffer(x0,y0) = distance;
        buffer(y0,x0) = distance;        
    end
end
%close(h);

rmin=min(min(buffer));
rmax=max(max(buffer));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargout == 0
    f=figure;%('Position',[100 100 550 400]);                                 %remove 'f='
    imagesc(buffer);
    %%
    colormap Jet;
    colorbar;
    axis image;    
    xlabel('Time index','FontSize',30,'FontWeight','bold');
    ylabel('Time index','FontSize',30,'FontWeight','bold');
    title('Recurrence Plot','FontSize',20,'FontWeight','bold');
    %%
    get(gcf,'CurrentAxes');
    set(gca,'YDir','normal')
    set(gca,'LineWidth',2,'FontSize',20,'FontWeight','bold');
   
    
    %% SAVING RESULT TO FILE --->
    filename=strcat(filename,' ColorRecurrencePlot');%remove
    saveas(f, fullfile(resultdir, filename ), 'jpeg');          %remove 
    
    %clear 
end



