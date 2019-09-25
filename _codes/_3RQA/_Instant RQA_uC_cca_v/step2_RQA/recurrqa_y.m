function rqa_stat = recurrqa_y(recurrpt,linepara)
% This program calculate the RQA statistics for a recurrence plot.
% Author: Hui Yang
% Affiliation:
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com
% input:
% recurrpt - recurrence point matrix D(xi,xj)- N by 2 matrix
% For e.g, it should be:
% 1 1
% 1 2
% 1 10
% 1 80
% 6 9
% ...
% linepara - the minimal limit of vert and Horzt line pattern, default = 2
% output:
% rqa_stat - RQA statistics - [recrate DET LMAX ENT TND LAM TT];


% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, “Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,” IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

if nargin<2 || isempty(linepara)
    linepara = 2;
end

W=max(recurrpt(:,1));
matrixsize=size(recurrpt);
if matrixsize(2)~=2
    fprintf('Please provide the right recurrence point matrix! Thank you!');
end

ptdiff = diff(recurrpt,1,2);
indices = find(ptdiff);
duprecurr = recurrpt(indices,:);
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

    DET = 100*sum(diag)/length(recurrpt);
    LMAX = max(diag);


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
    if isempty(vert); vert = 0; end

    vert=vert(find(vert>linepara));
    LAM = 100*sum(vert)/length(recurrpt);
    TT = mean(vert);

    if isempty(DET)||isnan(DET);DET = 0; end
    if isempty(LMAX)||isnan(LMAX);LMAX = 0; end
    if isempty(ENT)||isnan(ENT);ENT = 0; end
    if isempty(LAM)||isnan(LAM);LAM = 0; end
    if isempty(TT)||isnan(TT);TT = 0; end

    rqa_stat=[recrate DET LMAX ENT LAM TT];
    %rqa_stat=[recrate DET LMAX ENT TND LAM TT];
end
