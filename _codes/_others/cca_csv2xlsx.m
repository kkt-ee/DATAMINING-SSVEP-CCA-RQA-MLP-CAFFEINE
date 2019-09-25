
clear all

%%


ipdir='/mnt/pd/_ccaResult/result_/';
opdir='/mnt/pd/_ccaResult/result_/_ccainxlsx/'; 

%%
%ipdir='/mnt/pd/_ccaResult/_ccaRQA/AB132RQAtables/';
%opdir='/mnt/pd/_ccaResult/_ccaRQA/AB132RQAtables/inxlsx/'; 

%%
count=0;
for chx = 12%:22
    for px = 1:7
        fprintf('chx = %d px=%d\n',chx,px); count = count+1;
        
        ipfname=strcat(ipdir,'ABCh',num2str(chx),'Stim',num2str(px),'r6v.csv')  
        
        fdata = readtable(ipfname);
        
        opfname=strcat(opdir,'ABch',num2str(chx),'P',num2str(px),'.xlsx');
        writetable(fdata,opfname); clearvars fdata opfname ipfname
        
    end
end

