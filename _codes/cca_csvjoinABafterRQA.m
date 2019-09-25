%% joins CSV files and add a 'class Label' column

dirA='/mnt/pd/_ccaResult/result_/';
dirB='/mnt/pd/_ccaResult/result_/';

outputdir='/mnt/pd/_ccaResult/result_/';
%%
% creating new columns to add
xA=['A']; xB=['B'];
%NewColA=repmat(xA,[120 1]);
%NewColB=repmat(xB,[120 1]);

NewColA=repmat(xA,[24 1]);
NewColB=repmat(xB,[24 1]);
%%
for chx = 20:22
    for px = 1:7
        fprintf('chx = %d px=%d\n',chx,px);
        filenameA = strcat(dirA,'A','Ch',num2str(chx),'Stim',num2str(px),'r6v.csv')
        filenameB = strcat(dirB,'B','Ch',num2str(chx),'Stim',num2str(px),'r6v.csv')
        outputFileName= strcat(outputdir,'AB','Ch',num2str(chx),'Stim',num2str(px),'r6v.csv')

        % Step 1 - Read the file    % Step 2 - Add a column to the data
        %%
        tempA = readtable(filenameA); tempA = [array2table(NewColA),tempA]%(:,1:12)];
        tempB = readtable(filenameB); tempB = [array2table(NewColB),tempB]%(:,1:12)];
        %%
        tempA.Properties.VariableNames = {'LABEL','RR', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD' 'tau', 'dim'};
        tempB.Properties.VariableNames = {'LABEL','RR', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD','tau', 'dim'};
       %%
        % Step 3 - Save the file
        Tnew=table();
        Tnew=[tempA(:,1:12); tempB(:,1:12)];
        Tnew.Properties.VariableNames = {'LABEL','RR', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'AN', 'DIV', 'AD'};
        writetable(Tnew,outputFileName)
    
    end
end


%%
%ConstantVector = ones(size(VectorA))*((10^5)/((8.31434)*(298.15)))*(10^6);
%ConstantVectorA = ones(size(VectorA))*((10^5)/((8.31434)*(298.15)))*(10^6);
%ConstantVectorB = ones(size(VectorA))*((10^5)/((8.31434)*(298.15)))*(10^6);


%A=[1 2 3;4 5 6;7 8 9] % your matrix
%names={'a','b','c'}
%for k=1:numel(names)
  %assignin('base',names{k},A(:,k))
%end

%csv1 = csvread(filename1);
%csv2 = csvread(filename2);
%csv3 = csvread(filename3);
%allCsv = [csv1;csv2;csv3]; % Concatenate vertically
%csvwrite(outputFileName, allCsv);