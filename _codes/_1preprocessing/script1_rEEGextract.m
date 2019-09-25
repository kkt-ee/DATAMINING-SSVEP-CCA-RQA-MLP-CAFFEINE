% Script ID: rEEGextract
  %{
    An EEG signal is recorded from a volunteer. The entire signal contains
    embeds 7 differernt photic stimulus frequencies, each frequency of 
    20 sec duration. 
       The entire signal is in one excel file, each sheet containing 
    10 seconds of recording. This program is segments each photic 
    frequency regions (20s) and converts the entire data to a mat file.  
   %}
% author @kishore

% PROGRAM #1: Converting xls data to mat data 
%                  -- Cutting of signals of each d(=20) sec photic events 
%                  -- (O/P:7 EEG signals each of d(=20) sec duration)

% Nomenclatures in this program:
% 'rr' (at prefix of xls file name) denotes : rawraw (rr denotes multisheet xls file)
% similarly, r: raw (r denotes single sheet xls file)
% S = Sampling frequency (Hz)

clear all
%% USER INPUT >>> and RUN
% After caffeine raw EEG:  
%   rrssvep01d1A-ph37s.xlsx
%   rrssvep02d1A-ph13s.xlsx
%   rrssvep03d1A-ph15s.xlsx

% Before caffeine raw EEG: 
%   rrssvep01d1B-ph16s.xlsx
%   rrssvep02d1B-ph11s.xlsx
%   rrssvep03d1B-ph15s.xlsx (Therefore conversion of xlsx to mat files done)
% ---
%   

    loadedfile= '/mnt/pd/_SHELVE/rawDATA/_Placebo/v4d1B_69s.xlsx';
    %loadedfile='H:\_SHELVE\rawDATA\_Placebo\v5d1B_15s.xlsx'
    t1Hz =69; % (sec)

whos
%% PROGRAM SEGMENT 1 --RUN (if values entered)
% Converting rrEEG from sheetwise EEG data to one single sheet data
%% 1.1. Deleting empty sheets of xls file
% INPUT: xlsx file

[status,sheets]=xlsfinfo(loadedfile);                                                   %  >>>rrxlsfile<<<
disp(status)

sheets2del={'Sheet1','Sheet2','Sheet3'};
for i=1:3
    sheetname2del=sheets2del(i);
    index2del=find(ismember(sheets,sheetname2del));
    sheets(index2del)=[];
end                              % Therefore Done deleting 3 empty sheets

% RESULT: THUS NO. OF NON-EMPTY SHEETS IN THE rrXLS FILE KNOWN 
disp(sheets)             % (check variable sheets for more info)
clearvars -except sheets loadedfile t1Hz % removing unnessary variables                    >>>sheets<<<                

whos
%% Summary 1.1. :
% I/P - rrxls file
% O/P - 'sheets' variable (only non empty sheetnames)
% NEXT to work with variable 'sheets'
% using the above info NEXT CONVERT ALL SHEETS TO A SINGLE FILE

%% 1.2. Appending all sheets to a single sheet 
% INPUT: sheet (xlsfinfo object) --after deleting empty sheets
% Sheets = ['1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21' '22' . . . ] 
onesheet=[];

for i=1:numel(sheets)
    sheetname = num2str(i);      % creating 'sheetname' (the name of sheet in the rrxls file) 
    page=xlsread(loadedfile,sheetname);
    onesheet=[onesheet;page];    % Appended all sheets to one variable
end
% RESULT: onesheet                                                                         >>>onesheet<<<
% CHECK : onesheet(S*10*sheetnumber,:);     eg.onesheet(2560*2,:)
% ToDo --> write onesheet to a excelfile
clearvars -except onesheet t1Hz loadedfile
whos

%{ 
 I/P - rrxls file
 O/P - 'onesheet' variable
 NEXT to work with variable 'onesheet'
%}




whos
%% PROGRAM SEGMENT 2 --CUTTING INDIVIDUAL PHOTIC FREQUENCY SIGNALS (20s duration)
%  EXTRACTION FROM rEEG 
%% 2.1 DEFINING CONSTANTS

rEEG  =onesheet;     % changing variable name 
S     =256;          % sampling frequency (Hz)

clearvars onesheet
whos

nphoticdur =S*20;    % photic duration 20sec. Therefore S*20 samples   %TO CHANGE WHEN THE PROTOCOL IS CHANGED
n1Hz       =t1Hz*S;

%% 2.2 Segmenting signal w.r.t. photic frequencies 

% --initializing start points 
n5Hz  = n1Hz +25*S;
n10Hz = n5Hz +25*S;
n15Hz = n10Hz+25*S;
n20Hz = n15Hz+25*S;
n25Hz = n20Hz+25*S;
n30Hz = n25Hz+25*S;

whos
%%
for i=1:23   % Since, Total channels = 22 EEG + 1 ECG = 23
    %% 2.2.1. --cutting signal 
    %  --SIG( startpoint:startpoint+photicdurarion) 
    sig1Hz(:,i) = rEEG(n1Hz:n1Hz+nphoticdur-1,i)';
    sig5Hz(:,i) = rEEG(n5Hz:n5Hz+nphoticdur-1,i)';
    sig10Hz(:,i)= rEEG(n10Hz:n10Hz+nphoticdur-1,i)';
    sig15Hz(:,i)= rEEG(n15Hz:n15Hz+nphoticdur-1,i)';
    sig20Hz(:,i)= rEEG(n20Hz:n20Hz+nphoticdur-1,i)';
    %disp('ok2')
    sig25Hz(:,i)= rEEG(n25Hz:n25Hz+nphoticdur-1,i)';  
    sig30Hz(:,i)= rEEG(n30Hz:n30Hz+nphoticdur-1,i)';
end
clearvars i n1Hz n5Hz n10Hz n15Hz n20Hz n25Hz n30Hz rEEG nphoticdur t1Hz
whos
%% 2.3. STORING all cut segments of signal in a {cell array}
ssvep={sig1Hz, sig5Hz, sig10Hz, sig15Hz, sig20Hz, sig25Hz, sig30Hz};
ssvepnames={'sig1Hz', 'sig5Hz', 'sig10Hz', 'sig15Hz', 'sig20Hz', 'sig25Hz', 'sig30Hz'};

ssvep=ssvep';
ssvep(:,2)=ssvepnames

clearvars ssvepnames sig1Hz sig5Hz sig10Hz sig15Hz sig20Hz sig25Hz sig30Hz           % >>>ssvep<<<
whos
%end




%% 2.4. SAVING (USER INPUT >>> and RUN)  {cell array} 'ssvep' variable to .mat
%       e.g. rrssvep01d1A.xlsx : d1 v2 A
savepath  = '/mnt/pd/vars/'   %refer RQA for savin 
%savepath  = 'H:\vars\'   %refer RQA for savin 

day       = 'd1';
volunteer = 'v4';
class     = 'B';
% >>>>>>>>><<<<<<<<<

vname=strcat('ssvep',volunteer,day,class);        % output: ssvepv3d1B.mat
f=fullfile(savepath,vname);
%filename=strcat(vname,'.mat')
save(f, 'ssvep')









% Therefore,
% I/P - onesheet variable
% O/P - 'ssvep' cell array
% RESULT 'ssvep' 
%        (variable which contains individual segments of photic frequency) data

% NEXT: To operate on 'ssvep' variable from program segment 2  
%--------------------------------------------------[Program segment 2 end]







