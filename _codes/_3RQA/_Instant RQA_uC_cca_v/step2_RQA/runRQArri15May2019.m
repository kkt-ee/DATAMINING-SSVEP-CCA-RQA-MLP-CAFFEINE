clear all
global resultdir
format long

% [PREREQUISITE] lOAD WORKSPACE WITH THE 'RRI DATASET'(.mat file if saved) (calculated from --main_rri.m) 
%% 1. [ EDIT AND RUN ] >>>>ENTER VALUE<<<<
resultdir = '/mnt/pd/_rriResults_Summer18/now/';
load /mnt/pd/alGO/_SHELVE/RQA_uC-rri/step1_RRI/ECGsmokers5min/resampledRR4Hz.mat  %---------------enter



%%
Tnew=table();
        
        for vx = 2%:72  
  
            fprintf('sig no: %d\n', vx);
                        
            sigsegment = resampledRR{vx,1}; % sig = SSVEPdata(chx,a:b,vx,px); <<----------enter
            sigsegmentName= resampledRR{vx,2}
            %try
                RQAstat(vx,:) = RQA(sigsegment);                                % calling main()     % savefilename (change)             
            %catch
             %   RQAstat(vx,:) = [-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
            %end
            disp(RQAstat)
            %Tnew=[Tnew;array2table(RQAstat)]; %clearvars RQAstat
        end
        
        %%
        Tnew=array2table(RQAstat);
        Tnew.Properties.VariableNames = {'RR', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD', 'Tau', 'Dimension'};
        %%
        %filename=strcat(resultdir,label,chxhead,pxhead,'MABFall6vol.csv');
        filename=strcat(resultdir,'RQAstatRRI00.csv');
        writetable(Tnew,filename); %clearvars Tnew
