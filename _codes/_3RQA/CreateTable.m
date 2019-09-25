%% [supporting] fn 
% STEP 2 : -RQA-
%
% Creates table from the output of main()
%                       ....RQAstatistics
% Features:
% {'recrate', 'DET', 'LMAX', 'ENT', 'LAM', 'TT', 'VMAX', 'RATIO', 'avg_neighbours', 'DIV', 'Avg_diag'}

function Tnew=CreateTable(RQAstatistics)
Tnew=table();

    for i=1:length(RQAstatistics)
%try
        name=RQAstatistics{i,1};
        recrate = RQAstatistics{i,2}(1);
        DET = RQAstatistics{i,2}(2);
        LMAX = RQAstatistics{i,2}(3);
        ENT = RQAstatistics{i,2}(4);
        LAM = RQAstatistics{i,2}(5);
        TT = RQAstatistics{i,2}(6);
        VMAX = RQAstatistics{i,2}(7);
        RATIO = RQAstatistics{i,2}(8);
        avg_neighbours = RQAstatistics{i,2}(9);
        DIV = RQAstatistics{i,2}(10);
        Avg_diag = RQAstatistics{i,2}(11);
    
    
        statistics={name,recrate,DET,LMAX,ENT,LAM,TT,VMAX,RATIO,avg_neighbours,DIV,Avg_diag};
        Tnew=[Tnew;statistics];
%catch
 %   err={name, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};
  %  Tnew=[Tnew;err];
%end
    end

Tnew.Properties.VariableNames = {'Name','recrate', 'DET', 'LMAX', 'ENT', 'LAM', 'TT','VMAX', 'RATIO', 'Aavg_neighbours', 'DIV', 'Avg_diag'}
end


