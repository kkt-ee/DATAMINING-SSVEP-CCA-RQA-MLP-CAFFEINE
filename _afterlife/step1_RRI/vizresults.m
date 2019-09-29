%% [OPTIONAL] fn
% STEP 1 : -R-R Interval extract- 
%
% 5. To vizualize located R-peaks, 
%              ...i.e. results of locateR()

function vizresults(t,A,augmentedR, A_r, t_r, data_vname,figsavefolpath)
f=figure('units','normalized','outerposition',[0 0 1 1]); 
plot(t,A); hold on;            % remove f
plot(t,augmentedR)
                                              % ??????????
h = plot(t(t_r),A(t_r),'r*'); set(gca,'FontSize',20)
title(data_vname), xlabel('# sample point (n)','FontSize', 30), ylabel('Amplitude (V)','FontSize', 30);

ldg=legend('Original ECG','Augmented R-peaks','R-peaks')
lgd.FontSize = 16;
figsave(f,data_vname,figsavefolpath);        % comment out to save figures
end