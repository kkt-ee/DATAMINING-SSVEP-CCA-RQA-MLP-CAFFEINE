function out = false_nearest(signal,mindim,maxdim,tau,rt,eps0)
%Determines the fraction of false nearest neighbors.

%Author: Hui Yang
%Affiliation: 
       %The Pennsylvania State University
       %310 Leohard Building, University Park, PA
       %Email: yanghui@gmail.com

%signal: input time series     
%mindim - minimal dimension of the delay vectors 	1
%maxdim - maximal dimension of the delay vectors 	5
%tau - delay of the vectors 	1
%rt - ratio factor 	10.0

% If you find this demo useful, please cite the following paper:
% [1]	H. Yang, �Multiscale Recurrence Quantification Analysis of Spatial Vectorcardiogram (VCG) 
% Signals,� IEEE Transactions on Biomedical Engineering, Vol. 58, No. 2, p339-347, 2011
% DOI: 10.1109/TBME.2010.2063704
% [2]	Y. Chen and H. Yang, "Multiscale recurrence analysis of long-term nonlinear and 
% nonstationary time series," Chaos, Solitons and Fractals, Vol. 45, No. 7, p978-987, 2012 
% DOI: 10.1016/j.chaos.2012.03.013

if nargin<2 | isempty(mindim)
  mindim = 1;
end
if nargin<3 | isempty(maxdim)
  maxdim = 5;
end
if nargin<4 | isempty(tau)
  tau = 1;
end
if nargin<5 | isempty(rt)
  rt = 10;
end
if nargin<6 | isempty(eps0)
  eps0=1/1000;
end

minimum = min(signal);
maximum = max(signal);
interval = maximum-minimum;
len = length(signal);
BOX = 1024;
ibox = BOX-1;
theiler = 0;
global aveps vareps variance box list toolarge

for i = 1:1:len
    signal(i) =(signal(i)- minimum)/interval;
end
av = mean(signal);
variance = std(signal);


out = zeros(maxdim,4);

for dim = mindim:maxdim
    epsilon=eps0;
    toolarge=0;
    alldone=0;
    donesofar=0;
    aveps=0.0;
    vareps=0.0;
    
    for i=1:len
      nearest(i)=0;
    end
    
    %fprintf('Start for dimension=%d\n',dim);
    
    while (~alldone && (epsilon < 2*variance/rt)) 
        alldone=1;
        make_box(signal,len-1,dim,tau,epsilon);
        for i=(dim-1)*tau+1:(len-1)
            if (~nearest(i))
                nearest(i)=find_nearest(i,dim,tau,epsilon,signal,rt,theiler);
                alldone = bitand(alldone,nearest(i));
                donesofar = donesofar+nearest(i);
            end
        end
        
        %fprintf('Found %d up to epsilon=%d\n',donesofar,epsilon*interval);
        
        epsilon=epsilon*sqrt(2.0);
        if (~donesofar)
            eps0=epsilon;
        end
    end
    if (donesofar == 0)
      %fprintf('Not enough points found!\n');
      fnn = 0;
    else
        aveps = aveps*(1/donesofar);
        vareps = vareps*(1/donesofar);
        fnn = toolarge/donesofar;
    end

    out(dim,:) = [dim fnn aveps vareps];
    
end
  
  
function y = find_nearest(n,dim,tau,eps,signal,rt,theiler)
global aveps vareps variance box list toolarge

element=0;
which= -1;
dx=0;
maxdx=0;
mindx=1.1;
factor=0;
ibox=1023;

x=bitand(ceil(signal(n-(dim-1)*tau)/eps),ibox);
if x==0
    x=1;
end
y=bitand(ceil(signal(n)/eps),ibox);
if y==0
    y=1;
end

for x1=x-1:x+1
    if x1==0
        continue
    end
    x2= bitand(x1,ibox);
    for y1=y-1:y+1
        if y1==0
            continue
        end
        element = box(x2,bitand(y1,ibox));
        while (element ~= -1)
            if (abs(element-n) > theiler) 
                maxdx=abs(signal(n)-signal(element));
                for i=1:dim
                    i1=(i-1)*tau;
                    dx = abs(signal(n-i1)-signal(element-i1));
                    if (dx > maxdx)
                        maxdx=dx;
                    end
                end
                if ((maxdx < mindx) && (maxdx > 0.0))
                    which = element;
                    mindx = maxdx;
                end
            end
            element = list(element);
        end
    end
end

if ((which ~= -1) && (mindx <= eps) && (mindx <= variance/rt)) 
    aveps = aveps+mindx;
    vareps = vareps+mindx*mindx;
    factor=abs(signal(n+1)-signal(which+1))/mindx;
    if (factor > rt)
      toolarge=toolarge+1;
    end
    y = 1;
else
    y = 0;
end




function make_box(ser,l,dim,del,eps)
global box list
bs=1024;
ib=bs-1;

box = -ones(bs,bs);
  
for i=(dim-1)*del+1:l
    x = bitand(ceil(ser(i-(dim-1)*del)/eps),ib);
    if x==0
        x=1;
    end
    y = bitand(ceil(ser(i)/eps),ib);
    if y==0
        y=1;
    end
    list(i)=box(x,y);
    box(x,y)=i;
end


