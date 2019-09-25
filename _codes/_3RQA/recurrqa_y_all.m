function rqa_stat = recurrqa_y_all(recurrpt,linepara)
%%%%http://www.recurrence-plot.tk/rqa.php -> RQA PARAMETERS

if nargin<2 || isempty(linepara)
    linepara = 2;
end

%% NOT SURE ABOUT THIS
rec = recurrpt;
[N1,N2] = size(rec);
N = N1;
SR = sum(rec(:));
avg_neighbours = SR/N;
%%
W=max(recurrpt(:,1));%maximum of first coloumn
matrixsize=size(recurrpt);
if matrixsize(2)~=2
    fprintf('Please provide the right recurrence point matrix! Thank you!');
end

ptdiff = diff(recurrpt,1,2);
indices = find(ptdiff);
duprecurr = recurrpt(indices,:);%why??why take nonzero indices of first difference??
recurrpt = duprecurr;
clear duprecurr;

if isempty(recurrpt)
    rqa_stat = zeros(1,6);
else
    recrate=100*length(recurrpt)/(W*(W-1)/2);
    recurrpt = sortrows(recurrpt,1);
    recurrpt = horzcat(recurrpt,recurrpt(:,2)-recurrpt(:,1));
    recurrpt = sortrows(recurrpt,3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Horizorntal Line Structure Search
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    k=1;
    j=1;
    [row,col]=size(recurrpt);
    for i=1:row-1
        if recurrpt(i,3)==recurrpt(i+1,3)
            s{k}(j)=recurrpt(i,1);
            displace(k)=recurrpt(i,3);
            j=j+1;
            if i==length(recurrpt)-1
                s{k}(j)=recurrpt(i+1,1);
            end
        else
            s{k}(j)=recurrpt(i,1);
            j=1;
            k=k+1;
        end
    end

    k=1;
    diag = [];
    len=1;
    for i=1:length(s)
        for j=1:length(s{i})-1
            if s{i}(j)+1==s{i}(j+1)
                len=len+1;
            else
                diag(k)=len;
                disp(k)=displace(i);
                k=k+1;
                len=1;
            end
            if j==length(s{i})-1
                diag(k)=len;
                disp(k)=displace(i);
                k=k+1;
                len=1;
            end
        end
    end

    %TND=(disp')\(diag');
    if isempty(diag);diag = 0; end

    %Entropy Calculation
    diag=diag(find(diag>linepara));
    vect = diag(:);
    region = max(vect) - min(vect) + 1;
    freq = hist (vect, region);
    prob = freq / sum (freq);
    nonz = prob (find (prob));
    ENT = sum (nonz .* (-log2 (nonz)));

    DET = 100*sum(diag)/length(recurrpt);                                               % DET
    LMAX = max(diag);                                                                   % LMAX
    %avg_diag = mean(diag);                                                                          
    try 
    DIV = 1/LMAX;                                                                       % DIV
    catch
        DIV=99999;
        %disp(LMAX)
        %fprintf('Press key to resume...')
        %pause
    end
    Avg_diag = mean(diag);                                                              % Avg_diag
    
%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Vertical Line Structure Search
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear s;
    recurrpt = sortrows(recurrpt,1);
    k=1;
    j=1;
    for i=1:row-1
        if recurrpt(i,1)==recurrpt(i+1,1)
            s{k}(j)=recurrpt(i,2);
            j=j+1;
            if i==length(recurrpt)-1
                s{k}(j)=recurrpt(i+1,2);
            end
        else
            s{k}(j)=recurrpt(i,2);
            j=1;
            k=k+1;
        end
    end

    k=1;
    len=1;
    vert = [];
    for i=1:length(s)
        for j=1:length(s{i})-1
            if s{i}(j)+1==s{i}(j+1)
                len=len+1;
            else
                vert(k)=len;
                k=k+1;
                len=1;
            end
            if j==length(s{i})-1
                vert(k)=len;
                k=k+1;
                len=1;
            end
        end
    end
%%    
    if isempty(vert); vert = 0; end

    vert=vert(find(vert>linepara));
    LAM = 100*sum(vert)/length(recurrpt);
    TT = mean(vert);
    VMAX = max(vert);                                                                   % VMAX
    RATIO = DET/recrate;

    if isempty(DET)||isnan(DET);DET = 0; end
    if isempty(LMAX)||isnan(LMAX);LMAX = 0; end
    if isempty(ENT)||isnan(ENT);ENT = 0; end
    if isempty(LAM)||isnan(LAM);LAM = 0; end
    if isempty(TT)||isnan(TT);TT = 0; end
    if isempty(VMAX)||isnan(VMAX);VMAX = 0; end
    if isempty(RATIO)||isnan(RATIO);RATIO = 0; end
    if isempty(VMAX)||isnan(VMAX);VMAX = 0; end
    if isempty(DIV)||isnan(DIV);DIV = 0; end
    if isempty(avg_neighbours)||isnan(avg_neighbours);avg_neighbours = 0; end
    if isempty(Avg_diag)||isnan(Avg_diag);Avg_diag = 0; end

    rqa_stat=[recrate DET LMAX ENT LAM TT VMAX RATIO avg_neighbours DIV Avg_diag];       % DIV is redundant (1/Lmax)
    
    
    
    %N will be the number of rows
    
end
