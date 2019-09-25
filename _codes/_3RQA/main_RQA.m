%% [MAIN] fn
% STEP 2 : -RQA-
%
% RQAstatistics: R-R Intervals on Smokers data (Before and after smoking)
%                                    ---(computes for entire signal data)
%
%       sigVector : Output from STEP 1 (file: main_rri.m)
%
% !!! User INput: folder name for saving plots
% (move to run)

%% main fUNCTION : main_RQA()
function RQAstatistics = main_RQA(sigVector)%,resultdir)

global count
global resultdir
clc
errors = 'errors:\n';                                                        % To log for data that cannot be precessed from RR data
%MONTAGES={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2' 'ECG'};

% Path for saving plots in jpg format
%resultdir='_______________________'; 

% e.g. sigVector: 5121x23
%% THE BIG FOR LOOP (FOR ENTIRE DATA SET)
%count=0
p=4; c=6;                                                      % << input >>
RQAstatistics={};
for i=1:p*c
    
    savefilename=sigVector{i,1}; % sigVector=ssvep
    
    %for ch = 1:6 %length(sigVector(:,1))
        %length(sigVector)    
        close all
        %temp           =strcat(savefileheader);%,MONTAGES{ch});
        %savefilename   =temp;
        %clearvars temp
        %% 1/2 RQAstatistics column 1
        %***RQAstatistics{ch,1} = savefilename;                                              % RQAstatistics column 1 will store filenames
        RQAstatistics{i,1}=sigVector{i,1};  %for signame
        %% 2/2 RQAstatistics column 1
        %try
            sig = sigVector{i,2}{1};%(:,ch);%{1,1};     %{ph,1}(:,ch) UPGRADE                                          % Loading RR data frrom cells one by one from RRI data
            %***RQAstatistics{ch,2} = RQA(sig,savefilename)%,resultdir)                    % RQA(): fUNCTION call,                                                                        % THE CALCULATED STATISTICSAL DATAs : % RQAstatistics column 2
            RQAstatistics{i,2} = RQA(sig,savefilename)%,resultdir)
        %catch
            %errors=strcat(errors,' ',savefilename);                                      % In error cases "errors" string UPDATES
        %end

        %pause              % comment out for pausing after each execution
end

    %% saving as .mat
    %{
    if isempty(RQAstatistics) == 0
        vx=strcat(savefilename,'RQAstatistics');
        ff=fullfile(resultdir,vx);
        RQAstatistics=RQAstatistics';
        save(ff, 'RQAstatistics')
    end
    %}
%count=count+1
%% temporary
%{
Tnew=CreateTable(RQAstatistics);                   % fUNCTION CALL : CreateTable()

if count==1
    Tablefilename = '/mnt/pd/RGFT/v2d1A_5Hz_RQA.csv'; 
end
if count==2
    Tablefilename = '/mnt/pd/RGFT/v2d1A_10Hz_RQA.csv'; 
end
    
writetable(Tnew,Tablefilename);                    % Writing table to file 'Tablefilename'
%}

%%
fprintf(errors)
end