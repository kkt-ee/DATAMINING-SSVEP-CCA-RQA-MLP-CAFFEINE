for i=1:72
    try
        newRRIvector{i,2}=RRIvector{i,2}{:};  
    end
    newRRIvector{i,1}=RRIvector{i,1};
end


%% from here

clc
clearvars -except newRRIvector
resamplFs = 4; % Hz
for kx = 29%:72
    
    resampledRR{kx,2} = newRRIvector{kx,1}; % signal name
    try
        %%
        rry=newRRIvector{kx,2};
                
        for ix=1:numel(rry)
            if ix==1
                rrx(ix,1)=0;
            else
                rrx(ix,1) = rry(ix-1) + rrx(ix-1);
            end
        end
        
        %qp(:,1)=q; qp(:,2)=p;
        %%
        [newrr, Tnewrr] = resample(rry,rrx,resamplFs,'spline');
        
        %%{
        plot(rrx,rry,'. ','MarkerSize',9), set(gca,'FontSize',20)
        hold on
        plot(Tnewrr,newrr,'.-','MarkerSize',9)
        hold off
        lgd=legend('Original RR intervals','Resampled at 4 Hz using ''spline''')
        lgd.FontSize = 14;
        title('Resampled RR signals'), xlabel('# sample point (n)','FontSize', 30), ylabel('RR interval','FontSize', 30)
        %%}
        %%
        resampledRR{kx,1}=newrr; clearvars newrr Tnewrr rrx rry
        
        resampledRR
    end
end
    %{
        %sig(1)
        %temprri(:,1)=sig;



desiredFs = 44100;
[y, Ty] = resample(x,irregTx,desiredFs);
plot(irregTx,x,'.-', Ty,y,'o-')
legend('Original','Resampled')
ylim([-1.2 1.2])

[y, Ty] = resample(x,irregTx,desiredFs,'spline');

plot(irregTx,x,'. ')
hold on
plot(Ty,y,'.-')
hold off
legend('Original','Resampled using ''spline''')
ylim([-1.2 1.2])
%}