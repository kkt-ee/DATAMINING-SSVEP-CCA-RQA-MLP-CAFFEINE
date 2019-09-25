%% [CORE] fn 
% STEP 2 : -RQA-
% calculates RQAstatitistics for one signal

%{
load /mnt/pd/vars/sigVecVectorA1-6forRQA.mat
savefilename='deldel'
rrv=sigVecVector{1};
sig=rrv{1,2}{1};
%}

%%
%{
load /mnt/pd/alGO/_SHELVE/RQA_uc/step2_RQA/rrisample.mat
savefilename='deldel'
sig=RRIvector{1,2}{1};
%}
%%


%% core fUNCTION : RQA()
function RQAstatistics1x13=RQA(sig)%,resultdir)
global resultdir
%% 1. Mutual Information Test to determine the *Time Delay*                           |tau|
savefilename='savefilename';

try
    mutual(sig,savefilename);       %,resultdir);                                % fn call for plot 
    mi=mutual(sig,savefilename);    %,resultdir);                             % fn call for 'mi' values
    for i=2:length(mi)-1
        if mi(i-1)>mi(i) && mi(i)<mi(i+1)       
            %disp(mi(i))
            tau=i-1;                            % extracts delay 'tau'  from mi 
            break
        end
    end
    
    %the first minimum in delay axis is 'tau'
    %fprintf("tau = %d",tau)

catch
    fprintf("tau error")
    savefilename;
    pause
    tau=50
end

clearvars i mi

%% 2. FNN test to determine the *Embedding Dimension*                                 |dim| 

out=false_nearest(sig,1,10,tau);  %   change values tau
fnn = out(:,1:2);
%f1=figure;%('Position',[100 400 460 360]);
%plt=plot(fnn(:,1),fnn(:,2),'o-','MarkerSize',4.5);
%title('False nearest neighbor test','FontSize',10,'FontWeight','bold');
%xlabel('dimension','FontSize',10,'FontWeight','bold');
%ylabel('FNN','FontSize',10,'FontWeight','bold');
%get(gcf,'CurrentAxes');
%set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
%grid on;
%--------------------------------------------------------------------------
tempD=out(:,2);
for i=1:length(tempD)
    if tempD(i) < 0.02       %.02 default %remove
        %disp(mi(i))
        dim=i;                    % extracts dimension 'dim' from using FNN
        break
    end
end
% 'dim' is ideally where the curve touches '0 in x axis'
%fprintf("dimension = %d\n",dim);

%filename1=strcat(savefilename,' False nearest neighbor test');%remove
%saveas(f1, fullfile(resultdir, filename1), 'jpeg'); 

clearvars i tempD filename1 f1 out fnn plt
close all
%% 3. Phase Space Plot                                                                 |y|
try
Y = phasespace(sig,dim,tau);                                   % Output 'y'
%f2=figure;%('Position',[100 400 460 360]);
%plot3(Y(:,1),Y(:,2),Y(:,3),'-','LineWidth',1);
%title('EKG time-delay embedding - state space plot','FontSize',10,'FontWeight','bold');
%grid on;
%set(gca,'CameraPosition',[25.919 27.36 13.854]);
%xlabel('x(t)','FontSize',10,'FontWeight','bold');
%ylabel('x(t+\tau)','FontSize',10,'FontWeight','bold');
%zlabel('x(t+2\tau)','FontSize',10,'FontWeight','bold');
%set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

%filename1=strcat(savefilename,' EKG time-delay embedding - state space plot');%remove
%saveas(f2, fullfile(resultdir, filename1), 'jpeg');  %remove       

clearvars f2 filename1
close all

end
 %   pass
%% 4a. Color Recurrence Plot                                                          |recurdata|

cerecurr_y(Y,savefilename);%,resultdir);
cbuffer = cerecurr_y(Y);


%% 4b. Black-White Recurrence Plot                                                    |recurrpt|

cbuffer=cbuffer./100; % NOTE: scaling necessay of EEG data

tdrecurr_y(cbuffer,0.3,savefilename);%,resultdir); %DEFAULT=0.3
recurrpt = tdrecurr_y(cbuffer,0.3);

%close all
%% 5. RQA (Recurrence Quantification Analysis)                                        |RQAstatistics| 
                                                                                   %- RQA statistics - [recrate DET LMAX ENT TND LAM TT]
RQAstatistics = recurrqa_y_all(recurrpt);
RQAstatistics(12)=tau;
RQAstatistics(13)=dim;
RQAstatistics1x13=RQAstatistics;
%%

%dimdatafile='/mnt/pd/_ccaResult/dimdatafile';
%fileID = fopen(dimdatafile,'a')
%fprintf('%d\n'dim);
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