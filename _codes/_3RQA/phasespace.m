function [ Y ] = phasespace(signal,dim,tau)
%Author: Hui Yang
%Affiliation: 
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com
%signal: input time series
%tau: time delay
%Y: delay embedding matrix(T*dim)

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

N = length(signal);

T=N-(dim-1)*tau;    % Total points on phase space
Y=zeros(T,dim);     % Initialize the phase space

for i=1:T
   Y(i,:)= signal(i+(dim-1)*tau-sort((0:dim-1),'descend')*tau)';            % equation of phase space???
end

sizeY=size(Y,2);

if nargout == 0
    if sizeY == 2
        plot(Y(:,1),Y(:,2));
        xlabel('y1','FontSize',10,'FontWeight','bold');
        ylabel('y2','FontSize',10,'FontWeight','bold');
        get(gcf,'CurrentAxes');
        set(gca,'FontSize',10,'FontWeight','bold');
        grid on;
    else
        plot3(Y(:,1),Y(:,2),Y(:,3));
        xlabel('y1','FontSize',10,'FontWeight','bold');
        ylabel('y2','FontSize',10,'FontWeight','bold');
        zlabel('y3','FontSize',10,'FontWeight','bold');
        get(gcf,'CurrentAxes');
        set(gca,'FontSize',10,'FontWeight','bold');
        grid on;
    end
end