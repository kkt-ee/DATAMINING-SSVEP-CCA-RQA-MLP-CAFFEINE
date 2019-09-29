% author @kishore

%% --< OPTION 2 >-------< Prof. ZHANG >---
%% 3.2. CCA COMPUTATION:
clc
%close all
%clear all
%load('/mnt/pd/newvar6s/Xd1A1-18.mat')
%load('/mnt/pd/vars/_Xd1B1-6newconfigRAW.mat') % <<------enter X from script 4
load('/root/_HONEYsave/_workfinish/KISHORE-mtechPD_28May2019_ALLData/vars/dir3_ccaXvariate/BX.mat')
X4D=X; %clearvars -except X4D
whos
%% 3.2.1. Initialize parameters
vnos      =6;    
Fs        =256;                    % sampling rate
t_length  =20;                     % data length (20 s)
TW        =1:1:t_length;
TW_p      =round(TW*Fs);
%n_run     =3;% 20; =>volunteers    % number of used runs
sti_f     =[3 5 10 15 20 25 30];   % stimulus frequencies 10, 9, 8, 6 Hz
n_sti     =length(sti_f);          % number of stimulus frequencies
n_correct =zeros(2,length(TW));
hits=zeros(22,7,6);

% 6x3 runs (enable 1 line from below)
figheader = 'before';%'8r (B): cca2 coefficient #1 (3-30 Hz)' % 1, 2, 3 <<-------------------enter
%(done)figheader = 'Raw signal (B): cca coefficient #3' % 1, 2, 3
%(done)figheader = 'Moving mean filtered signal (A): cca coefficient #3'  % 1, 2, 3
%(done)figheader = 'Moving mean filtered signal (B): cca coefficient #3'  % 1, 2, 3
%figheader = 'BF signal (A): cca coefficient #1'  % 1, 2, 3
%figheader = 'BF signal (A): cca coefficient #1'  % 1, 2, 3

%% 3.2.3. [Y] % Harmonics generation for CCA 

%  [Y] --cannonical variate 
%  Construct reference signals of sine-cosine waves
N=2; %2    % number of harmonics
ref1=refsig(sti_f(1),Fs,t_length*Fs,N); % photic1 sig + N harmonics
ref2=refsig(sti_f(2),Fs,t_length*Fs,N); % photic2 sig + N harmonics
ref3=refsig(sti_f(3),Fs,t_length*Fs,N); % photic3 sig + N harmonics
ref4=refsig(sti_f(4),Fs,t_length*Fs,N); % photic4 sig + N harmonics
ref5=refsig(sti_f(5),Fs,t_length*Fs,N); % photic5 sig + N harmonics
ref6=refsig(sti_f(6),Fs,t_length*Fs,N); % photic6 sig + N harmonics
ref7=refsig(sti_f(7),Fs,t_length*Fs,N); % photic7 sig + N harmonics


%% [X] --cannonical variate AND CCA(X,Y) :: CCA for SSVEP recognition
%function coeffs = computecca(X4D,Y)
sigDetect = zeros(22,7,6); % ch, ph, v
for k=1:22 % => 4D data of 22Channels                                                               % Ch+Neighbour (5 x 5121 x 3 x 7) x 20 --pick one and process
    fprintf('[ch=%d] ',k)
    %[X] --cannonical variate
    SSVEPdata=X4D{k};
    
    %% --Recognition
    for run=1:vnos                                                                                     % 1:volunteerNos.
        %fprintf('v=%d',run)
        n_correct=zeros(2,length(TW));
        
        %fhits=zeros(1,7);
        for tw_length=1:1:t_length %:4 *      % time window length:  1s:1s:4s                            % 1:timeWindow(in sec)
            %dispflag=0;       % flag<+>
            %fprintf('Channel %d CCA Processing... TW %fs, No.crossvalidation %d \n',k,TW(tw_length),run);
            for j=1%:7 %:4 *                                                                             % 7Photic stimulus
                [wx1,wy1,r1]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref1(:,1:TW_p(tw_length)));
                [wx2,wy2,r2]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref2(:,1:TW_p(tw_length)));
                [wx3,wy3,r3]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref3(:,1:TW_p(tw_length)));
                [wx4,wy4,r4]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref4(:,1:TW_p(tw_length)));
                [wx5,wy5,r5]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref5(:,1:TW_p(tw_length)));
                [wx6,wy6,r6]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref6(:,1:TW_p(tw_length)));
                [wx7,wy7,r7]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref7(:,1:TW_p(tw_length)));
                
                %% (tune) cca coefficient 1, 2, 3
                [v,idx] = max([max(r1),max(r2),max(r3),max(r4),max(r5),max(r6),max(r7)]);         % cca coefficient #1
                %[v,idx] = max([max(wx1),max(wx2),max(wx3),max(wx4),max(wx5),max(wx6),max(wx7)]); % cca coefficient #2
                %[v,idx] = max([max(wy1),max(wy2),max(wy3),max(wy4),max(wy5),max(wy6),max(wy7)]); % cca coefficient #3
                
                %fprintf('idx %s\n',j)
                %fprintf('v=%d *(stim)j=%d *idxbefore= %d \n',run,j,idx)
                
                if idx==j                                                  % it means frequency match detected
                    %fprintf('j= %d\n',j)
                    
                    %fprintf('correct match, v=%d *(stim)j=%d  *idxafter= %d\n',run,j,idx)
                    n_correct(1,tw_length)=n_correct(1,tw_length)+1;     % no of correct hits
                    
                    %n_correct_(k,jtw_length)=n_correct(1,tw_length)+1
                    sigDetect(k,j,run)=1;                                   % <new entry>
                    hits(k,j,run)=hits(k,j,run)+1;                          % <new entry><-----OUTPUT
                    
                    %fhits(j)=fhits(j)+1                                   % <new entry>
                    %pause
                end 
                clearvars idx
                                               
                %sumtemp = sum(n_correct(1,:));                              % <new entry>
                %n_correctStimNos(j) = sumtemp; clearvars sumtemp        
            end   
        end
        %n_correctALL(:,run) = n_correctStimNos;
           
        %% 
        %{
        if run==vnos %(change)
            n_correctALL_(k,:,:) = n_correctALL;
        end
        %}
    end
end

%% Deduction: sigDetect [22 x 7 x 6]  (Answered: How many volunteers had positive match?, )
% sumVecVolper = 22x7 matrix  
clear sumVecVolper sumVecStimper %n_cALL2Dproj1Dproj_v n_cALL2Dproj1Dproj_h
for chx = 1:22
    for px = 1:7
        % ---------------deduction #1       
        tempvec = hits(chx,px,:);
        sumDetectallVol2D(chx,px) = sum(tempvec); clearvars tempvec   %---#1
               
    end
    sumDetectallCh(chx,1) = sum(sumDetectallVol2D(chx,:));             %  #2
end
clearvars chx px tempvec

for phx=1:7
    sumVecStimper(phx) = sum(sumDetectallVol2D(:,phx));                  % #1
    %n_cALL2Dproj1Dproj_h(phx)= sum(n_correctALL_2Dproj(:,phx));     % #2  
end

clearvars phx
sumDetectallVol2D 
sumVecStimper
%n_cALL2Dproj1Dproj_v 
%n_cALL2Dproj1Dproj_h
%% PLOTs sigDetect --> sumVecVolper, n_correctAll_ --> 

%Channels={'PG1' 'PG2' 'FP1' 'FP2' 'F3' 'F4' 'F7' 'F8' };


Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);
%{
%-- barplot 1--
figure, bar(c,sumDetectallVol2D)%(:,2:end))
    xlabel('EEG channel','FontSize', 35), ylabel('Number of volunteers','FontSize', 35), title(figheader); 
    lgd = legend('3 Hz','5 Hz','10 Hz','15 Hz','20 Hz','25 Hz','30 Hz');
    lgd.FontSize = 16;
    set(gca,'FontSize',16)
    clearvars lgd
%}


% --barplot 2-- summing up all photic hits in each channel
%%{
A=sumDetectallCh;%=featureScaling(hits)
%normA = A - min(A(:))
normA=A;
normA = normA ./ max(normA(:))
%%}

figure, bar(c,normA)
    xlabel('EEG channel','FontSize', 50), ylabel('% SSVEP hits','FontSize', 50), title(figheader); 
    set(gca,'FontSize',16)
    %clearvars lgd

%% ----------SAVE the PLOT and variable 'normA' (from workspace) for next step-------- 
   % run for before and after stimulus
   
   
   
   
   
   
%{    
% ---barplot 3 ---    
%freqs={'3 Hz' '5 Hz' '10 Hz' '15 Hz' '20 Hz' '25 Hz' '30 Hz'};
%f=categorical(freqs);

clearvars A normA
A=sumVecStimper; clearvars hitss
normA = A - min(A(:));
normA = normA ./ max(normA(:));

figure, bar(normA)
set(gca,'FontSize',16,'xticklabel',{'3 Hz' '5 Hz' '10 Hz' '15 Hz' '20 Hz' '25 Hz' '30 Hz'});
xlabel('Stimulus frequency','FontSize', 35), ylabel('SSVEP hit % ','FontSize', 35), title(figheader); 

%}

%lgd.FontSize = 16;

%set(gca,'FontSize',16)
%clearvars lgd
%xlabel('EEG channel'), ylabel('Number of SSVEP hits'), title(figheader);