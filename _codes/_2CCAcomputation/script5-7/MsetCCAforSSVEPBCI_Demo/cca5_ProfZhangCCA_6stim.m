% author @kishore

%% --< OPTION 2 >-------< Prof. ZHANG >---
%% 3.2. CCA COMPUTATION:
clc
clear all
%load('/mnt/pd/newvar6s/Xd1A1-18.mat')
load('/mnt/pd/vars/_Xd1B1-6newconfigMABF.mat') 
X4D=X; %clearvars -except X4D
whos
%% 3.2.1. Initialize parameters
vnos      =6;    
Fs        =256;                    % sampling rate
t_length  =20;                     % data length (4 s)
TW        =1:1:t_length;
TW_p      =round(TW*Fs);
%n_run     =3;% 20; =>volunteers    % number of used runs
sti_f     =[1 5 10 15 20 25 30];   % stimulus frequencies 10, 9, 8, 6 Hz
n_sti     =length(sti_f);          % number of stimulus frequencies
n_correct =zeros(2,length(TW));

% 6x3 runs (enable 1 line from below)
figheader = 'mabf signal (B): cca coefficient #1 (5-30 Hz)' % 1, 2, 3
%(done)figheader = 'Raw signal (B): cca coefficient #3' % 1, 2, 3
%(done)figheader = 'Moving mean filtered signal (A): cca coefficient #3'  % 1, 2, 3
%(done)figheader = 'Moving mean filtered signal (B): cca coefficient #3'  % 1, 2, 3
%figheader = 'BF signal (A): cca coefficient #1'  % 1, 2, 3
%figheader = 'BF signal (A): cca coefficient #1'  % 1, 2, 3

%% 3.2.2. LOAD data: X4Dssvepdata_4CHselection.mat {22x1} cell array of 4D variables [channel + neighbours]
%{
try
    load('/mnt/pd/vars/X/X4Dssvepdata_4CHselection.mat')     % LINUX  
catch
    load('G:\vars\X\X4Dssvepdata_4CHselection.mat')          % Windows
end
%}
%%

%% 3.2.3. [Y] % Harmonics generation for CCA 

%  [Y] --cannonical variate 
%  Construct reference signals of sine-cosine waves
N=2; %2    % number of harmonics
%ref1=refsig(sti_f(1),Fs,t_length*Fs,N); % photic1 sig + N harmonics
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

    %[X] --cannonical variate
    SSVEPdata=X4D{k};
    
    %% --Recognition
    for run=1:vnos                                                                                     % 1:volunteerNos.
        n_correct=zeros(2,length(TW));
        
        for tw_length=1:1:t_length %:4 *      % time window length:  1s:1s:4s                            % 1:timeWindow(in sec)
            %dispflag=0;       % flag<+>
            fprintf('Channel %d CCA Processing... TW %fs, No.crossvalidation %d \n',k,TW(tw_length),run);
            for j=2:7 %:4 *                                                                             % 7Photic stimulus
                %[wx1,wy1,r1]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref1(:,1:TW_p(tw_length)));
                [wx2,wy2,r2]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref2(:,1:TW_p(tw_length)));
                [wx3,wy3,r3]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref3(:,1:TW_p(tw_length)));
                [wx4,wy4,r4]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref4(:,1:TW_p(tw_length)));
                [wx5,wy5,r5]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref5(:,1:TW_p(tw_length)));
                [wx6,wy6,r6]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref6(:,1:TW_p(tw_length)));
                [wx7,wy7,r7]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref7(:,1:TW_p(tw_length)));
                
                %% (tune) cca coefficient 1, 2, 3
                [v,idx] = max([max(r2),max(r3),max(r4),max(r5),max(r6),max(r7)]);         % cca coefficient #1
                %[v,idx] = max([max(wx2),max(wx3),max(wx4),max(wx5),max(wx6),max(wx7)]); % cca coefficient #2
                %[v,idx] = max([max(wy2),max(wy3),max(wy4),max(wy5),max(wy6),max(wy7)]); % cca coefficient #3
                
                %fprintf('idx %s\n',j)
                fprintf('v=%d *(stim)j=%d *idxbefore= %d \n',run,j,idx)
                
                if idx==j                                                  % it means frequency match detected
                    %fprintf('---==idx %s\n',j)
                    fprintf('correct match, v=%d *(stim)j=%d  *idxafter= %d\n',run,j,idx)
                    n_correct(1,tw_length)=n_correct(1,tw_length)+1;
                    
                    sigDetect(k,j,run)=1;                                   % <new entry>
                end 
                clearvars idx
                
                % this 'if' is not needed -->> 
                %if j==7 && tw_length==t_length
                 %   n_correct
                %end % <<--
                                
                sumtemp = sum(n_correct(1,:));                              % <new entry>
                n_correctStimNos(j) = sumtemp; clearvars sumtemp        
            end
        end
        
        n_correctALL(:,run) = n_correctStimNos;
        
        %%
        if run==vnos %(change)
            n_correctALL_(k,:,:) = n_correctALL;
        end
    end
end

%% Deduction: sigDetect [22 x 7 x 6]  (Answered: How many volunteers had positive match?, )
% sumVecVolper = 22x7 matrix  
clear sumVecVolper sumVecStimper n_cALL2Dproj1Dproj_v n_cALL2Dproj1Dproj_h
for chx = 1:22
    for px = 2:7
        % ---------------deduction #1
        tempvec=sigDetect(chx,px,:);
        sumVecVolper(chx,px) = sum(tempvec); clearvars tempvec
        % ---------------deduction #2
        tempvec=n_correctALL_(chx,px,:);
        n_correctALL_2Dproj(chx,px) = sum(tempvec); clearvars tempvec
    end
    sumVecChper(chx,1) = sum(sumVecVolper(chx,:));                     % #1
    n_cALL2Dproj1Dproj_v(chx,1) = sum(n_correctALL_2Dproj(chx,:));     % #2
end
clearvars chx px tempvec

for phx=2:7
    sumVecStimper(phx) = sum(sumVecVolper(:,phx));                  % #1
    n_cALL2Dproj1Dproj_h(phx)= sum(n_correctALL_2Dproj(:,phx));     % #2
end
clearvars phx
sumVecVolper 
sumVecStimper
n_cALL2Dproj1Dproj_v 
n_cALL2Dproj1Dproj_h
%% PLOTs sigDetect --> sumVecVolper, n_correctAll_ --> 

Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%-- barplot 1--
figure, bar(c,sumVecVolper(:,2:end))
xlabel('EEG channel'), ylabel('Number of volunteers'), title(figheader); 
legend('5 Hz','10 Hz','15 Hz','20 Hz','25 Hz','30 Hz');

%-- barplot 2--
figure, bar(c,n_correctALL_2Dproj(:,2:end))
xlabel('EEG channel'), ylabel('Number of hits (SSVEP signal)'), title(figheader); 
legend('5 Hz','10 Hz','15 Hz','20 Hz','25 Hz','30 Hz');

%%
