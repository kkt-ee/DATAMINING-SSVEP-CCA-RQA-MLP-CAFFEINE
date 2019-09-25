function mi = mutual(signal,savefilename,partitions,tau)
%Estimates the time delayed mutual information of the data set
%Author: Hui Yang
%Affiliation: 
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com
       
%input: signal - input time series
%input: partitions - number of boxes for the partition
%input: tau - maximal time delay
%output: mi - mutual information from 0 to tau

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

%global resultdir

av       = mean(signal);
variance = var(signal);
minimum  = min(signal);
maximum  = max(signal);
interval = maximum-minimum;
len      = length(signal);


if nargin<4 | isempty(partitions)  %replace 3or4 with 2
  partitions = 16;
end
if nargin<5 | isempty(tau)         %replace 4or5 with 3
  tau = 40;  % DEFAULT: tau=20;
end

for i = 1:1:len
    signal(i) =(signal(i)- minimum)/interval;
end

for i = 1:1:len
    if signal(i) > 0 
        array(i) = ceil(signal(i)*partitions);
    else
        array(i) = 1;
    end
end

shannon = make_cond_entropy(0,array,len,partitions);
    
if (tau >= len)
    tau=len-1;
end

for i = 0:1:tau
    mi(i+1) = make_cond_entropy(i,array,len,partitions);
end


%if nargout == 0
 %   f=figure;%('Position',[100 400 460 360]);
  %  plot(0:1:tau,mi,'o-','MarkerSize',5);
    %title('Mutual Information Test (first local minimum)','FontSize',10,'FontWeight','bold');
    %xlabel('Delay (sampling time)','FontSize',10,'FontWeight','bold');
    %ylabel('Mutual Information','FontSize',10,'FontWeight','bold');
    %get(gcf,'CurrentAxes');
    %set(gca,'FontSize',10,'FontWeight','bold');
    %grid on;
    
    %savefilename=strcat(savefilename,' Mutual Information Test (first local minimum)')%remove
    %saveas(f, fullfile(resultdir, savefilename), 'jpeg');          %remove  
%end


function mi = make_cond_entropy(t,array,len,partitions)

hi=0;
hii=0;
count=0;
hpi=0;
hpj=0;
pij=0;
cond_ent=0.0;


h2 = zeros(partitions,partitions);

for i = 1:1:partitions
    h1(i)=0;
    h11(i)=0;
end

for i=1:1:len
    if i > t
        hii = array(i);
        hi = array(i-t);
        h1(hi) = h1(hi)+1;
        h11(hii) = h11(hii)+1;
        h2(hi,hii) = h2(hi,hii)+1;
        count = count+1;
    end
end

norm=1.0/double(count);
cond_ent=0.0;

for i=1:1:partitions
    hpi = double(h1(i))*norm;
    if hpi > 0.0
        for j = 1:1:partitions
            hpj = double(h11(j))*norm;
            if hpj > 0.0
                pij = double(h2(i,j))*norm;
                if (pij > 0.0)
                    cond_ent = cond_ent + pij*log(pij/hpj/hpi);
                end
            end
        end
    end
end

mi = cond_ent;

