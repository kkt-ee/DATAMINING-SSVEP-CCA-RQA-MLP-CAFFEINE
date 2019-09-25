load /mnt/pd/vars/maSSVEP6chB1-6
%%
SSVEPdata=newsig;
whos
cmatrix=zeros(6);

for vid=1
    for p=1
        for sigid1=1:6
            sig1=SSVEPdata(sigid1,:,vid,p);
            for sigid2=1:6
                sig2=SSVEPdata(sigid2,:,vid,p);
                %calc covariance
                c=cov(sig1,sig2);
                cmatrix(sigid1,sigid2)=c(1,2);

           
            
            fprintf('1')
        end
        %fprintf('2')
    end
    %fprintf('3')
    end
end
%normalizedc = normalize_var(cmatrix, 0, 255)
%%
cmin=min(cmatrix(:));
cmax=max(cmatrix(:));
tmin=0;
tmax=255;

for r =1:6
    for c=1:6
        p=cmatrix(r,c);
        np(r,c)=(p-cmin)/(cmax-cmin)*(tmax-tmin)+tmin;
    end
end
np
%%
figure('Position',[100 100 550 400]);                                 %remove 'f='
imagesc(np);
colormap Jet;
colorbar;
%%
axis image;    
xlabel('SSVEP channels','FontSize',10,'FontWeight','bold');
ylabel('SSVEP channels','FontSize',10,'FontWeight','bold');
title('Covariance Plot','FontSize',10,'FontWeight','bold');
    %%
    get(gcf,'CurrentAxes');
    set(gca,'YDir','normal')
    set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
   


%%

%%
%sig1=newsig(1,:,1,1);
%sig2=newsig(2,:,1,1);


