%% [OPTIONAL] fn
% STEP 1 : -R-R Interval extract- 

% 6. To save the figure generated in vizresults() to directory:
%                                         .....'figsavefolpath'

function figsave(f,data_vname,figsavefolpath)
%figsavefolpath = '_____________';
saveas(f, fullfile(figsavefolpath, data_vname), 'jpeg');  
end