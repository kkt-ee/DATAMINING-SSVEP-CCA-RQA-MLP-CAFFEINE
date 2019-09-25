clear all
global resultdir

% [PREREQUISITE] lOAD WORKSPACE WITH THE 'RRI DATASET'(.mat file if saved) (calculated from --main_rri.m) 
%% 1. [ EDIT AND RUN ] >>>>ENTER VALUE<<<<
resultdir = '/mnt/pd/_ccaResult/_ccaRQA/';
load /mnt/pd/vars/mabfSSVEPdataB1-6.mat  %---------------enter
label='B'; % <<------------------------------------------enter
fs=256;



%% Band pass filter
%bandFilt = designfilt('bandpassiir', 'FilterOrder', 6, 'HalfPowerFrequency1',3,'HalfPowerFrequency2',80,'SampleRate', fs);
%sig = filtfilt(bandFilt,sig); 

a=1; span = 255;
%% 
for chx = 1:22                  % 22 channels
    chxhead=strcat('Ch',num2str(chx));
    
    for px = 1:7                % 5 hz to 30 hz signals ( 6 Nos)
        pxhead= strcat('Stim',num2str(px));
        Tnew=table();
        
        for vx = 1:6            % 6 volunteers           
            fprintf('chx=%d px=%d vx=%d\n',chx, px, vx);
            
            for segmentno=1:20  % 20 segments of 1second
                
                b=a+span;
                sigsegment = mabfSSVEPdata(chx,a:b,vx,px); % sig = SSVEPdata(chx,a:b,vx,px); <<----------enter
                %%
                %filtsigsegment = filtfilt(bandFilt,sigsegment);  % applying bandpass filter
                RQAstat(segmentno,:) = RQA(sigsegment);      % calling main()     % savefilename (change)           
                
                if segmentno==20
                    a=1;
                else 
                    a=b+1;
                end
            end
            disp(RQAstat)
            Tnew=[Tnew;array2table(RQAstat)]; clearvars RQAstat
        end
        
        Tnew.Properties.VariableNames = {'Recrate', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD', 'Tau', 'Dimension'};
        %writematrix(RQAstat,'RM.xls','Sheet',2,'Range','A3:E8')
        filename=strcat(resultdir,label,chxhead,pxhead,'MABFall6vol.csv');
        writetable(Tnew,filename); clearvars Tnew
    end
end