%% t-test
% follow up script of "splitToCategoryTables.m"

% stats{'Name','recrate','DET','LMAX','ENT','LAM','TT','VMAX','RATIO','avg_neighbours','DIV','Avg_diag'};
% Categories={'P1AS','P1BS','P2AS','P2BS','P3AS','P3BS' };


%% For 3 Phases
[h_p1 p_p1 ci_p1 tstats_p1] = P123_ttest2(P1AS,P1BS);
[h_p2 p_p2 ci_p2 tstats_p2] = P123_ttest2(P2AS,P2BS);
[h_p3 p_p3 ci_p3 tstats_p3] = P123_ttest2(P3AS,P3BS);
%% Table format
t_statistics=table();
t_statistics=[t_statistics;{h_p1},{h_p2},{h_p3}];
t_statistics=[t_statistics;{p_p1},{p_p2},{p_p3}];
t_statistics=[t_statistics;{ci_p1(1,:)},{ci_p2(1,:)},{ci_p3(1,:)};...
                        {ci_p1(2,:)},{ci_p2(2,:)},{ci_p3(2,:)}];

t_statistics.Properties.VariableNames = {'Phase1','Phase2','Phase3'};
t_statistics.Properties.RowNames = {'hypothesis','p_value','ci1','ci2'};

%%
writetable(t_statistics,'t-test_data.xlsx')

%%
function [hypothesis p_values CI t_STATS] = P123_ttest2(a,b)

[hrecrate precrate cirecrate t_statsrecrate]=ttest2(a.recrate,b.recrate);
[hDET pDET ciDET t_statsDET]=ttest2(a.DET,b.DET);
[hLMAX pLMAX ciLMAX t_statsLMAX]=ttest2(a.LMAX,b.LMAX);
[hENT pENT ciENT t_statsENT]=ttest2(a.ENT,b.ENT);
[hLAM pLAM ciLAM t_statsLAM]=ttest2(a.LAM,b.LAM);
[hTT pTT ciTT t_statsTT]=ttest2(a.TT,b.TT);

[hVMAX pVMAX ciVMAX t_statsVMAX]=ttest2(a.VMAX,b.VMAX);
[hRATIO pRATIO ciRATIO t_statsRATIO]=ttest2(a.RATIO,b.RATIO);
[hRATIO pRATIO ciRATIO t_statsRATIO]=ttest2(a.RATIO,b.RATIO);
[havg_neighbours pavg_neighbours ciavg_neighbours t_statsavg_neighbours]=ttest2(a.avg_neighbours,b.avg_neighbours);
[hDIV pDIV ciDIV t_statsDIV]=ttest2(a.DIV,b.DIV);
[hAvg_diag pAvg_diag ciAvg_diag t_statsAvg_diag]=ttest2(a.Avg_diag,b.Avg_diag);
%'','','','',''

hypothesis = [hrecrate hDET hLMAX hENT hLAM hTT hVMAX hRATIO havg_neighbours hDIV hAvg_diag];
p_values = [precrate pDET pLMAX pENT pLAM pTT pVMAX pRATIO pavg_neighbours pDIV pAvg_diag];
CI = [cirecrate ciDET ciLMAX ciENT ciLAM ciTT ciVMAX ciRATIO ciavg_neighbours ciDIV ciAvg_diag];
t_STATS = [t_statsrecrate t_statsDET t_statsLMAX t_statsENT t_statsLAM t_statsTT t_statsVMAX t_statsRATIO t_statsavg_neighbours t_statsDIV t_statsAvg_diag];
end
