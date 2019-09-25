%% ---Prof. Zhang----- section 2 ----- use (ctrl+enter to run the segments)(RUN EACH GROUP INDIVIDUALLY)
% author@ kishore
%% Title: Convert existing variables to 4D data:

%% 1. LOAD: { cell array }
clear
%%
day='d1';
whos
%% [A]---< After caffeine stimulus >---(GROUP 1)
label='A';
load('/mnt/pd/vars/ssvepv1d1A.mat'); v1d1A=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv2d1A.mat'); v2d1A=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv3d1A.mat'); v3d1A=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv4d1A.mat'); v4d1A=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv5d1A.mat'); v5d1A=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv6d1A.mat'); v6d1A=ssvep; clearvars ssvep

whos

%% [B] ---< Before caffeine stimulus >---(GROUP 2)

label='B';
load('/mnt/pd/vars/ssvepv1d1B.mat'); v1d1B=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv2d1B.mat'); v2d1B=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv3d1B.mat'); v3d1B=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv4d1B.mat'); v4d1B=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv5d1B.mat'); v5d1B=ssvep; clearvars ssvep
load('/mnt/pd/vars/ssvepv6d1B.mat'); v6d1B=ssvep; clearvars ssvep

whos

%{   
%% -nextgen ;) [ v4 onwards . . . ]
   label='B';
   %%
   load '/mnt/pd/vars/ssvepv5d1B.mat'; v5d1B=ssvep; clearvars ssvep
   whos
%}
%% 2. CONVERT: WHOLE DATASET TO 4D ARRAY : [A] and [B]
%% ---< tutorial >----
%  channels X sample points X volunteers/trials X stimulus   

% (1/7Nos) 3D array
% DE1Hz(:,:,1)=v1d1A{1,1}; % v1 1Hz 
% DE1Hz(:,:,2)=v2d1A{1,1}; % v2 1Hz
% DE1Hz(:,:,3)=v3d1A{1,1}; % v3 1Hz

% Similarly,
% DE5Hz DE10Hz DE15Hz ... DE30Hz

%% --< {cell} to [3D] >--
pick=[1 5 10 15 20 25 30];  % Photic stimulus frequencies
%% --loop: photic freq.
for k=1:7
    %% --DEheader => photic freq.
    DEheader=strcat('DE',int2str(pick(k)),'Hz');
    %% --loop: volunteer
    for i=1:6  % (3) #volunteers
     %% --nameheader => volunteer
        nameheader=strcat('v',int2str(i),day,label);                        % >> user input define above #label #day                      
        %% dynamic variable for, DE1Hz(:,:,1)=v1d1A{1,1};
        tempsig=eval([nameheader '{k,1}']); % done upgrade section {1, 1}
        tempsig=tempsig(:,1:22);
        tempsig=tempsig';
        eval([ DEheader '(:,:,i)' '=tempsig' ]) 
    end
end

clearvars DEheader i k nameheader pick tempsig
whos

%% --< create [3D] to [4D] >--
SSVEPdata=cat(4,DE1Hz,DE5Hz,DE10Hz,DE15Hz,DE20Hz,DE25Hz,DE30Hz);
whos


%% --< EDIT AND SAVE >--
filename='/mnt/pd/vars/SSVEPdataB1-6.mat' %1-3.mat';   % saves variable in '$ pwd' <<<<<---------------
save(filename, 'SSVEPdata')









