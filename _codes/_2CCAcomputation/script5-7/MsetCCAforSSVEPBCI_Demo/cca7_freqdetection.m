% author @kishore

%% --< OPTION 2 >-------< Prof. ZHANG >---
%% 3.2. CCA COMPUTATION:
clc
clear all
%impch =[8,10,11,12,14,15];
%X4D=X; %clearvars -except X4D
%whos
load('/mnt/pd/vars/maSSVEP6chB1-6_6b.mat')
%% 3.2.1. Initialize parameters
Fs        =256;                    % sampling rate
t_length  =20;                     % data length (4 s)
TW        =1:1:t_length;
TW_p      =round(TW*Fs);
n_run     =3;% 20; =>volunteers    % number of used runs
sti_f     =[1 5 10 15 20 25 30];   % stimulus frequencies 10, 9, 8, 6 Hz
n_sti     =length(sti_f);          % number of stimulus frequencies
n_correct =zeros(2,length(TW));

%{
%% 3.2.2. LOAD data: X4Dssvepdata_4CHselection.mat {22x1} cell array of 4D variables [channel + neighbours]
%load('/mnt/pd/vars/maSSVEPdataB1-6.mat')
%PG1=1; P3=8; O1=9; FZ=10; CZ=11; PZ=12; PG2=14; FP2=15; 
%chosench=[PG1,P3,O1,FZ,CZ,PZ,PG2,FP2];                                     % dominant channels

for v=1:6
    for ph=1:7
        for ch=1:8
            chosenSSVEPch(ch,:,v,ph)=maSSVEPdata(chosench(ch),:,v,ph);     % selecting the dominant channels
        end
    end
end
%{
try
    load('/mnt/pd/vars/X/X4Dssvepdata_4CHselection.mat')     % LINUX  
catch
    load('G:\vars\X\X4Dssvepdata_4CHselection.mat')          % Windows
end
%}
%}
%%

%% 3.2.3. CCA for SSVEP recognition

%  [Y] --cannonical variate 
%  Construct reference signals of sine-cosine waves
N=2; %2    % number of harmonics
ref1=refsig(sti_f(1),Fs,t_length*Fs,N); % photic1 sig + N harmonics
ref2=refsig(sti_f(2),Fs,t_length*Fs,N); % photic2 sig + N harmonics
ref3=refsig(sti_f(3),Fs,t_length*Fs,N); % photic3 sig + N harmonics
ref4=refsig(sti_f(4),Fs,t_length*Fs,N); % photic4 sig + N harmonics
% 3 more *
ref5=refsig(sti_f(5),Fs,t_length*Fs,N); % photic5 sig + N harmonics
ref6=refsig(sti_f(6),Fs,t_length*Fs,N); % photic6 sig + N harmonics
ref7=refsig(sti_f(7),Fs,t_length*Fs,N); % photic7 sig + N harmonics


%% [X] --cannonical variate AND CCA(X,Y)
%function coeffs = computecca(X4D,Y)
%for k=1:22 % => 4D data of 22Channels                                                               % Ch+Neighbour (5 x 5121 x 3 x 7) x 20 --pick one and process

    %[X] --cannonical variate
    %SSVEPdata=X4D{k};
    SSVEPdata=newsig;
    
    %% --Recognition
    for run=1:6  %:20 *                                                                                 % volunteerNo.
        n_correct=zeros(2,length(TW));
        for tw_length=1:20 %:4 *      % time window length:  1s:1s:4s                                   % time window
            dispflag=0;       % flag<+>
            fprintf('CCA Processing... TW %fs, No.crossvalidation %d \n',TW(tw_length),run);
            for j=1:7 %:4 *                                                                             % 7Photic stimulus
                [wx1,wy1,r1]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref1(:,1:TW_p(tw_length)));
                [wx2,wy2,r2]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref2(:,1:TW_p(tw_length)));
                [wx3,wy3,r3]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref3(:,1:TW_p(tw_length)));
                [wx4,wy4,r4]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref4(:,1:TW_p(tw_length)));
                [wx5,wy5,r5]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref5(:,1:TW_p(tw_length)));
                [wx6,wy6,r6]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref6(:,1:TW_p(tw_length)));
                [wx7,wy7,r7]=cca(SSVEPdata(:,1:TW_p(tw_length),run,j),ref7(:,1:TW_p(tw_length)));
                 
                coeffph1(j)=max(r1); coeffph11(j)=max(max(wx1)); coeffph111(j)=max(max(wy1)); 
                coeffph2(j)=max(r2); coeffph21(j)=max(max(wx2)); coeffph211(j)=max(max(wy2));
                coeffph3(j)=max(r3); coeffph31(j)=max(max(wx3)); coeffph311(j)=max(max(wy3));
                coeffph4(j)=max(r4); coeffph41(j)=max(max(wx4)); coeffph411(j)=max(max(wy4));
                coeffph5(j)=max(r5); coeffph51(j)=max(max(wx5)); coeffph511(j)=max(max(wy5));
                coeffph6(j)=max(r6); coeffph61(j)=max(max(wx6)); coeffph611(j)=max(max(wy6));
                coeffph7(j)=max(r7); coeffph71(j)=max(max(wx7)); coeffph711(j)=max(max(wy7));
                
                
                [val,idx]=max([max(r1),max(r2),max(r3),max(r4),max(r5),max(r6),max(r7)]);             
                %fprintf('idx %s\n',j)
                fprintf('v=%d *(stim)j=%d *idxbefore= %d \n',run,j,idx)
                if idx==j
                    %fprintf('---==idx %s\n',j)
                    fprintf('v=%d *(stim)j=%d  *idxafter= %d\n',run,j,idx)
                    n_correct(1,tw_length)=n_correct(1,tw_length)+1;
                end
                if j==7 && tw_length==20
                    n_correct                    
                end
            end
        end
        %n_correctcell{k} =n_correct;
        %ADDcell{k}       =ADD;
        n_correctALL(:,:,run)=n_correct;
        %%
        %
        %if run==6 %(change)
         %   n_correctALL_{k,1}=n_correctALL
        %end
    end
%end


                    [calc1,idx1]=max(coeffph1); [calc11,idx11]=max(coeffph11); [calc111,idx111]=max(coeffph111);
                    [calc2,idx2]=max(coeffph2); [calc21,idx21]=max(coeffph21); [calc211,idx211]=max(coeffph211);
                    [calc3,idx3]=max(coeffph3); [calc31,idx31]=max(coeffph31); [calc311,idx311]=max(coeffph311);
                    [calc4,idx4]=max(coeffph4); [calc41,idx41]=max(coeffph41); [calc411,idx411]=max(coeffph411);
                    [calc5,idx5]=max(coeffph5); [calc51,idx51]=max(coeffph51); [calc511,idx511]=max(coeffph511);
                    [calc6,idx6]=max(coeffph6); [calc61,idx61]=max(coeffph61); [calc611,idx611]=max(coeffph611);
                    [calc7,idx7]=max(coeffph7); [calc71,idx71]=max(coeffph71); [calc711,idx711]=max(coeffph711);
                    %%
fprintf('\nLabel:    1 2 3 4 5 6 7 \nDetected: %d %d %d %d %d %d %d \nwhere, \n1=>1Hz \n2=>5Hz \n3=>10Hz \n4=>15Hz \n5=>20Hz \n6=>25Hz \n7=>30Hz\n',idx1, idx2, idx3, idx4, idx5, idx6, idx7)
fprintf('\nwx\nLabel:    1 2 3 4 5 6 7 \nDetected: %d %d %d %d %d %d %d \n',idx11, idx21, idx31, idx41, idx51, idx61, idx71)
fprintf('\nwy\nLabel:    1 2 3 4 5 6 7 \nDetected: %d %d %d %d %d %d %d \n',idx111, idx211, idx311, idx411, idx511, idx611, idx711)
%{

%% 3.3.3. sum(n_correctALL_{i})
for ss=1:22
    ADD1(ss)=sum(n_correctALL_{ss,:}(1,:,1));
    ADD2(ss)=sum(n_correctALL_{ss,:}(1,:,2));
    ADD3(ss)=sum(n_correctALL_{ss,:}(1,:,3));
    ADD4(ss)=sum(n_correctALL_{ss,:}(1,:,4));
    ADD5(ss)=sum(n_correctALL_{ss,:}(1,:,5));
    ADD6(ss)=sum(n_correctALL_{ss,:}(1,:,6));
end
ADD1=ADD1';
ADD2=ADD2';
ADD3=ADD3';
ADD4=ADD4';
ADD5=ADD5';
ADD6=ADD6';

ADD(:,:,1)=ADD1;
ADD(:,:,2)=ADD2;
ADD(:,:,3)=ADD3;
ADD(:,:,4)=ADD4;
ADD(:,:,5)=ADD5;
ADD(:,:,6)=ADD6;

ADD








%% 3.3.4. ---< VISUALIZATION OF RESULTS >---

Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%c = categorical({'apples','pears','oranges'});
v=ADD(:,:,2);
stem(c,v), xlabel('EEG channels'),ylabel('Occurences of SSVEP') 

%% Sort ADD
for p=1:6 % volunteers
   [val,idxx]=sort(ADD(:,:,p),'descend');
   orderedADD(p,:)=idxx'
end
%%
chosenelectrodes=orderedADD(:,1:8)
%%
n=histogram(chosenelectrodes)
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
%}