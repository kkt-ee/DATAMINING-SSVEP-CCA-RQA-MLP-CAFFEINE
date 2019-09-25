%% [CORE] fn 
% STEP 2 : -RQA-
% calculates RQAstatitistics for one signal



%% core fUNCTION : RQA()
function [RQAstatistics recurdata]=RQA(ecg,filename,folname)
%% 1. Mutual Information Test to determine the *Time Delay*                           |tau|

mutual(ecg,filename,folname);                                % fn call for plot 
mi=mutual(ecg,filename,folname);                             % fn call for 'mi' values
for i=2:length(mi)-1
    if mi(i-1)>mi(i) && mi(i)<mi(i+1)       
        %disp(mi(i))
        tau=i-1;                            % extracts delay 'tau'  from mi 
        break
    end
end
%the first minimum in delay axis is 'tau'
fprintf("tau = %d",tau)

%% 2. FNN test to determine the *Embedding Dimension*                                 |dim| 

out=false_nearest(ecg,1,10,tau);  %   change values tau
fnn = out(:,1:2);
f1=figure;%('Position',[100 400 460 360]);
plt=plot(fnn(:,1),fnn(:,2),'o-','MarkerSize',4.5);
title('False nearest neighbor test','FontSize',10,'FontWeight','bold');
xlabel('dimension','FontSize',10,'FontWeight','bold');
ylabel('FNN','FontSize',10,'FontWeight','bold');
get(gcf,'CurrentAxes');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
grid on;
%--------------------------------------------------------------------------
tempD=out(:,2);
for i=1:length(tempD)
    if tempD(i) < 0.02       
        %disp(mi(i))
        dim=i;                    % extracts dimension 'dim' from using FNN
        break
    end
end
% 'dim' is ideally where the curve touches '0 in x axis'
fprintf("dimension = %d\n",dim);

filename1=strcat(filename,' False nearest neighbor test');%remove
saveas(f1, fullfile(folname, filename1), 'jpeg'); 


%% 3. Phase Space Plot                                                                 |y|

y = phasespace(ecg,dim,tau);                                   % Output 'y'
f2=figure;%('Position',[100 400 460 360]);
plot3(y(:,1),y(:,2),y(:,3),'-','LineWidth',1);
title('EKG time-delay embedding - state space plot','FontSize',10,'FontWeight','bold');
grid on;
set(gca,'CameraPosition',[25.919 27.36 13.854]);
xlabel('x(t)','FontSize',10,'FontWeight','bold');
ylabel('x(t+\tau)','FontSize',10,'FontWeight','bold');
zlabel('x(t+2\tau)','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

filename1=strcat(filename,' EKG time-delay embedding - state space plot');%remove
saveas(f2, fullfile(folname, filename1), 'jpeg');  %remove       

%% 4a. Color Recurrence Plot                                                          |recurdata|

cerecurr_y(y,filename,folname);
recurdata = cerecurr_y(y);


%% 4b. Black-White Recurrence Plot                                                    |recurrpt|

tdrecurr_y(recurdata,0.3,filename,folname);
recurrpt = tdrecurr_y(recurdata,0.3);


%% 5. RQA (Recurrence Quantification Analysis)                                        |RQAstatistics| 
                                                                                   %- RQA statistics - [recrate DET LMAX ENT TND LAM TT]
RQAstatistics = recurrqa_y_all(recurrpt);


end





% The above steps to be run inside a for loop for the complete R-R interval data set

%% 6. Feature reduction (Orange --by ranking)
%% 7. Neural network (to do...)


%
% Tool box of recurrence plot and recurrence quantification analysis - Author: Hui Yang
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG)
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012
% DOI: 10.1016/j.chaos.2012.03.013
%
%
% -------------------------------------------------------------------------
% ---Program reused and edited by: Kishore, NIT Rourkela, date: May 2018 