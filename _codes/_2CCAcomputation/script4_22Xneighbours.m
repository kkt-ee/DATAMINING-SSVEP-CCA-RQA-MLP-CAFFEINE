%% 2.1.1. LOAD .mat file ( 4D EEG data )
clear all
%{
try
    %load('/mnt/pd/vars/dir2_4D_rawANDma/maSSVEPdataA1-3.mat')
    %load 'maSSVEPdataB1-3.mat'
    load '/mnt/pd/vars/maSSVEPdataB5.mat'
catch
    load('G:\vars\maSSVEPdataA1-3.mat')
end
%}
%load /mnt/pd/newvar6s/maSSVEPdataB1-18.mat
load /mnt/pd/vars/mabfSSVEPdataB1-6_w40.mat               %-------enter RESULT GENERATED FROM SCRIPT 3b (4d ARRAY)
V=numel(mabfSSVEPdata(1,1,:,1)); % V = #volunteers    %-------enter

%%
neighbid =neighbours();
X =x22wNeigh(mabfSSVEPdata,neighbid,V)                %-------enter

%% SAVING 'X'
filename='/mnt/pd/vars/_Xd1B1-6newconfigMABF_w40.mat';   % saves variable in '$ pwd'
save(filename, 'X')



%% fUNCTIONS:
%% 2.2.2 Cannonical variate 'X'
%  supersetX ={[] [] [] ..... []}  %contains patch of channels 'X'
% ...
% ..../

function neighbids=neighbours()
PG1=1; FP1=2; F7=3; F3=4; T3=5; C3=6; T5=7; P3=8; O1=9; FZ=10;...
       CZ=11; PZ=12; OZ=13; PG2=14; FP2=15; F8=16; F4=17; T4=18;...
       C4=19; T6=20; P4=21; O2=22;

% selecting 4 Neighbours of each channel
neighbids= [PG1	FZ	F3;...
            FP1 FZ PG1;...
            F7  CZ  F3;...
            F3  CZ  FZ;...
            T3  T5  O1;...
            C3	P3  F7;...
            T5	OZ  O1;...
            P3	C3  PZ;...
            O1	T3  P3;...
            FZ FP1 FP2;...
            CZ	C3	C4;...
            PZ	O1	O2;...
            OZ	O1	O2;...
            PG2	FZ	F4;...
            FP2 FZ PG2;...
            F8	CZ	F4;...
            F4  CZ	FZ;...
            T4	T6  O2;...
            C4	P4	F8;...
            T6	OZ	O2;...
            P4	C4  PZ;...
            O2	T4	P4 ];
end

%% Returns a cell array of 22 nos of 4D matrix for 22 channels and neighbours
function X=x22wNeigh(sig4D,neighbids,V)
for v=1:V
    for p=1:7
        for sigid=1:22
            neigh=neighbids(sigid,:);
            n0=sig4D(neigh(1),:,v,p);
            n1=sig4D(neigh(2),:,v,p);
            n2=sig4D(neigh(3),:,v,p);
            
            tempX=[n0; n1; n2]; %{sigid,1}
            X{sigid,1}(:,:,v,p)=tempX;
        end
    end
end
end

% #---------------------SAVE 'X' FROM WORKSPACE

