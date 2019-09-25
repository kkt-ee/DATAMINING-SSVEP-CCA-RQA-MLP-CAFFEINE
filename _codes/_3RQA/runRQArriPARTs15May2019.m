clear all
global resultdir
format long

% [PREREQUISITE] lOAD WORKSPACE WITH THE 'RRI DATASET'(.mat file if saved) (calculated from --main_rri.m) 
%% 1. [ EDIT AND RUN ] >>>>ENTER VALUE<<<<
resultdir = '/mnt/pd/_rriResults_Summer18/';
load /mnt/pd/alGO/_SHELVE/RQA_uC-rri/step1_RRI/ECGsmokers5min/resampledRR4Hz.mat  %---------------enter


a=1; %span = 255;
%%
Tnew=table();
        
        for vx = 49:72
            sigW = resampledRR{vx,1}; % sig = SSVEPdata(chx,a:b,vx,px); <<----------enter
            sigWName= resampledRR{vx,2}
            
            span=floor( numel(sigW)/4 ); fprintf('span: %d\n',span)
%%
            for segx=1:4  % 20 segments of 1second
                fprintf('Signal: %d    segment: %d\n',vx,segx);
                
                b=a+span-1; fprintf('a: %4d    b: %4d\n',a,b)
                sigsegment=sigW(a:b);
                if segx==4
                   sigsegment=sigW(a:end); 
                end
                
                try
                    RQAstat(segx,:) = RQA(sigsegment);                                % calling main()     % savefilename (change)             
                catch
                    RQAstat(segx,:) = [-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
                end
                
                if segx==4
                    a=1; 
                else 
                    a=b+1;
                end
                clearvars b
                
            end
  %%    
            disp(RQAstat)
            Tnew=[Tnew;array2table(RQAstat)]; clearvars RQAstat
        end
        
        Tnew.Properties.VariableNames = {'RR', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD', 'Tau', 'Dimension'};
        %writematrix(RQAstat,'RM.xls','Sheet',2,'Range','A3:E8')
        filename=strcat(resultdir,'P3_RQAstatRRIparts.csv');
        writetable(Tnew,filename); %clearvars Tnew

        
        
  
            
                      
         