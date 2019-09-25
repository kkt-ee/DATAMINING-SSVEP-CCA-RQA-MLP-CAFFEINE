% author @kishore

%% --< OPTION 2 >-------< Prof. ZHANG >---
%% 3.2. CCA COMPUTATION:
clc
clear all
%load('/mnt/pd/newvar6s/Xd1A1-18.mat')
load('/mnt/pd/vars/_Xd1A1-6.mat') 
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

    %[X] --cannonical variate
    SSVEPdata=X4D{k};
    
    %% --Recognition
    for run=1:vnos                                                                                     % 1:volunteerNos.
        n_correct=zeros(2,length(TW));
        
        for tw_length=1:1:t_length %:4 *      % time window length:  1s:1s:4s                            % 1:timeWindow(in sec)
            dispflag=0;       % flag<+>
            fprintf('Channel %d CCA Processing... TW %fs, No.crossvalidation %d \n',k,TW(tw_length),run);
            for j=1:7 %:4 *                                                                             % 7Photic stimulus
                [wx1,wy1,r1]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref1(:,1:TW_p(tw_length)));
                [wx2,wy2,r2]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref2(:,1:TW_p(tw_length)));
                [wx3,wy3,r3]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref3(:,1:TW_p(tw_length)));
                [wx4,wy4,r4]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref4(:,1:TW_p(tw_length)));
                [wx5,wy5,r5]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref5(:,1:TW_p(tw_length)));
                [wx6,wy6,r6]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref6(:,1:TW_p(tw_length)));
                [wx7,wy7,r7]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref7(:,1:TW_p(tw_length)));
                
                %[v,idx] = max([max(r1),max(r2),max(r3),max(r4),max(r5),max(r6),max(r7)]);
                [v,idx] = max([max(wx1),max(wx2),max(wx3),max(wx4),max(wx5),max(wx6),max(wx7)]);
                %[v,idx] = max([max(wy1),max(wy2),max(wy3),max(wy4),max(wy5),max(wy6),max(wy7)]);
                
                %fprintf('idx %s\n',j)
                fprintf('v=%d *(stim)j=%d *idxbefore= %d \n',run,j,idx)
                
                if idx==j                                                  % it means frequency match detected
                    %fprintf('---==idx %s\n',j)
                    fprintf('correct match, v=%d *(stim)j=%d  *idxafter= %d\n',run,j,idx)
                    n_correct(1,tw_length)=n_correct(1,tw_length)+1;
                    
                    sigDetect(k,j,run)=1;                                   % <new entry>
                end 
                clearvars idx
                
                % this 'if' is not needed 
                if j==7 && tw_length==t_length
                    n_correct
                end % <<--
                                
                sumtemp = sum(n_correct(1,:));                              % <new entry>
                n_correctStimNos(j) = sumtemp; clearvars sumtemp
                
            end
        end
        %n_correctcell{k} =n_correct;
        %ADDcell{k}       =ADD;
        n_correctALL(:,:,run)=n_correctStimNos;
        %%
        %
        if run==vnos %(change)
            n_correctALL_{k,1}=n_correctALL
        end
    end
end

%% Deduction: sigDetect [22 x 7 x 6]  (Answered: How many volunteers had positive match?)
% sumVecVolper = 22x7 matrix  
%
%
for chx = 1:22
    for px = 1:7
        tempvec=sigDetect(chx,px,:);
        sumVecVolper(chx,px) = sum(tempvec); 
    end
    sumVecChper(chx,1) = sum(sumVecVolper(chx,:));
end
clearvars chx px tempvec

for phx=1:7
    sumVecStimper(phx) = sum(sumVecVolper(:,phx));
end
clearvars phx

%% PLOTs

Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%-- barplot 1--
bar(c,sumVecVolper)
xlabel('EEG channel'), ylabel('Number of volunteers'), title('For Canonical coefficient #2'); 
legend('1 Hz','5 Hz','10 Hz','15 Hz','20 Hz','25 Hz','30 Hz');

%-- stem plot 1-- 
figure, h = stem(c,sumVecVolper)
xlabel('EEG channel'), ylabel('Number of volunteers'), title('For Canonical coefficient #2'); 
legend('1 Hz','5 Hz','10 Hz','15 Hz','20 Hz','25 Hz','30 Hz');
h(1).Color = 'r'; h(1).Marker= 'o';
h(2).Color = 'm'; h(2).Marker= '+';
h(3).Color = 'b'; h(3).Marker= '*';
h(4).Color = 'r'; h(4).Marker= 'x';
h(5).Color = 'g'; h(5).Marker= 's';
h(6).Color = 'm'; h(6).Marker= 'd';
h(7).Color = 'b'; h(7).Marker= 'p';

%% Deduction 2 (Frequency of matches

%for chx = 1%:22
  %  tempd  = n_correctALL_{chx};
 %   tempdd = tempd(:,:,1)
%    sumtemp= sum(tempdd(1,:))

%end



%% 3.3.3. sum(n_correctALL_{i})
for ss=1:22
    ADD1(ss)=sum(n_correctALL_{ss,:}(1,:,1));
    ADD2(ss)=sum(n_correctALL_{ss,:}(1,:,2));
    ADD3(ss)=sum(n_correctALL_{ss,:}(1,:,3));
    ADD4(ss)=sum(n_correctALL_{ss,:}(1,:,4));
    ADD5(ss)=sum(n_correctALL_{ss,:}(1,:,5));
    ADD6(ss)=sum(n_correctALL_{ss,:}(1,:,6));
    %{
    ADD7(ss)=sum(n_correctALL_{ss,:}(1,:,7));
    ADD8(ss)=sum(n_correctALL_{ss,:}(1,:,8));
    ADD9(ss)=sum(n_correctALL_{ss,:}(1,:,9));
    ADD10(ss)=sum(n_correctALL_{ss,:}(1,:,10));
    ADD11(ss)=sum(n_correctALL_{ss,:}(1,:,11));
    ADD12(ss)=sum(n_correctALL_{ss,:}(1,:,12));
    ADD13(ss)=sum(n_correctALL_{ss,:}(1,:,13));
    ADD14(ss)=sum(n_correctALL_{ss,:}(1,:,14));
    ADD15(ss)=sum(n_correctALL_{ss,:}(1,:,15));
    ADD16(ss)=sum(n_correctALL_{ss,:}(1,:,16));
    ADD17(ss)=sum(n_correctALL_{ss,:}(1,:,17));
    ADD18(ss)=sum(n_correctALL_{ss,:}(1,:,18));
    %}
end

ADD1=ADD1';
ADD2=ADD2';
ADD3=ADD3';
ADD4=ADD4';
ADD5=ADD5';
ADD6=ADD6';
%{
ADD7=ADD7';
ADD8=ADD8';
ADD9=ADD9';
ADD10=ADD10';
ADD11=ADD11';
ADD12=ADD12';
ADD13=ADD13';
ADD14=ADD14';
ADD15=ADD15';
ADD16=ADD16';
ADD17=ADD17';
ADD18=ADD18';
%}

ADD(:,:,1)=ADD1;
ADD(:,:,2)=ADD2;
ADD(:,:,3)=ADD3;
ADD(:,:,4)=ADD4;
ADD(:,:,5)=ADD5;
ADD(:,:,6)=ADD6;
%{
ADD(:,:,7)=ADD7;
ADD(:,:,8)=ADD8;
ADD(:,:,9)=ADD9;
ADD(:,:,10)=ADD10;
ADD(:,:,11)=ADD11;
ADD(:,:,12)=ADD12;
ADD(:,:,13)=ADD13;
ADD(:,:,14)=ADD14;
ADD(:,:,15)=ADD15;
ADD(:,:,16)=ADD16;
ADD(:,:,17)=ADD17;
ADD(:,:,18)=ADD18;
%}
ADD








%% 3.3.4. ---< VISUALIZATION OF RESULTS >---

Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%c = categorical({'apples','pears','oranges'});
v=ADD(:,:,3);
stem(c,v), xlabel('EEG channels'),ylabel('Occurences of SSVEP') 

%% Sort ADD
for p=1:vnos % volunteers
   [val,idxx]=sort(ADD(:,:,p),'descend');
   orderedADD(p,:)=idxx'
end
%%
chosenelectrodes=orderedADD(:,1:8)
%%
n=histogram(chosenelectrodes)
xlabel('EEG channels'),ylabel('Occurences of SSVEP') 
% Create strings for each bar count
%barstrings = num2str(n');
% Create text objects at each location
%text(x,n,barstrings,'horizontalalignment','center','verticalalignment','bottom')


%% --< tutorial >--
% y = [2 4 6; 3 4 5];
% b = bar(y);

%%
%F=[1 5 10 15 20 25 30];
%T=20;

%t=[1:.1:20];
%y=square(t)
%%
%plot(t,square)