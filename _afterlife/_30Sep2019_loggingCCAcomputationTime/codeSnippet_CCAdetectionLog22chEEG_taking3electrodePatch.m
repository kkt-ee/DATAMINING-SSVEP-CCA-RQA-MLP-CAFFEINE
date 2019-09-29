% code snippet for the detecttion of SSVEP signals from 
% 22 channel EEG data using CCA
$------------------------------------------

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

figheader = 'r (A): cca coefficient #1 (3-30 Hz) w=40' % 1, 2, 3 <<-------------------enter

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
diary CCAdetectionLog22chEEG_taking3electrodePatch
disp("START")
disp("generating log using 'diary'...")

whos
X4D
tic %for calculating execution time --CCA detection time
sigDetect = zeros(22,7,6); % ch, ph, v
for k=1:22 % => 4D data of 22Channels                                                               % Ch+Neighbour (5 x 5121 x 3 x 7) x 20 --pick one and process
    fprintf('[ch=%d] ',k)
    %[X] --cannonical variate
    SSVEPdata=X4D{k};
    
    %% --Recognition
    for run=1:vnos                                                                                     % 1:volunteerNos.
        %fprintf('v=%d',run)
        n_correct=zeros(2,length(TW));
        
        for tw_length=1:1:t_length %:4 *      % time window length:  1s:1s:4s                            % 1:timeWindow(in sec)
            %dispflag=0;       % flag<+>
            %fprintf('Channel %d CCA Processing... TW %fs, No.crossvalidation %d \n',k,TW(tw_length),run);
            for j=1:7 %:4 *                                                                             % 7Photic stimulus
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
                    %fprintf('---==idx %s\n',j)
                    
                    %fprintf('correct match, v=%d *(stim)j=%d  *idxafter= %d\n',run,j,idx)
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
toc
diary off
type CCAdetectionLog22chEEG_taking3electrodePatch