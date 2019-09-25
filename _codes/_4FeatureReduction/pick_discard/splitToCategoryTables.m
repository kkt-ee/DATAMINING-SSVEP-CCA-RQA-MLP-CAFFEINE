%% two variable t-test for RQA statistics data

% Step 1: Import "Complete Table" & create "smaller category wise tables".
% Step 2: Perform ttest2 of 2 variables.



%%
%Phases=['P1','P2','P3'];
Categories={'P1AS','P1BS','P2AS','P2BS','P3AS','P3BS' };
[P1AS,P1BS,P2AS,P2BS,P3AS,P3BS] = categorytables(Tnew,Categories);





%% making tables category wise

function [P1AS,P1BS,P2AS,P2BS,P3AS,P3BS]=categorytables(Tnew,Categories)

for i=1:length(Categories)
    T=table();
    
    for j=1:length(Tnew.Name)
       
       if strcmp(Categories{i},Tnew.Name{j})==1
           statistics={Tnew.Name(j),Tnew.recrate(j),Tnew.DET(j),Tnew.LMAX(j),Tnew.ENT(j),Tnew.LAM(j),Tnew.TT(j)};
           T=[T;statistics];         
       end
    end
    
    %disp(T)
    T.Properties.VariableNames = {'Name','recrate', 'DET', 'LMAX', 'ENT', 'LAM', 'TT'};
    varname=Categories{i};
    eval([varname '=T;']);
end
end
%%        


