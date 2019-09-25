for i=1:22
    temp1=v1d1B24ChEnergy(i,:);
    temp2=v2d1B24ChEnergy(i,:);
    temp3=v3d1B24ChEnergy(i,:);
    u1(i,1)  =mean(temp1);
    u2(i,1)  =mean(temp2);
    u3(i,1)  =mean(temp3);
    mx1(i,1) =max(temp1);
    mx2(i,1) =max(temp2);
    mx3(i,1) =max(temp3);
end

%%
Channels={'PG1' 'FP1' 'F7' 'F3' 'T3' 'C3' 'T5' 'P3' 'O1' 'FZ' 'CZ' 'PZ' 'OZ' 'PG2' 'FP2' 'F8' 'F4' 'T4' 'C4' 'T6' 'P4' 'O2'};
c=categorical(Channels);

%v=ADD(:,:,3);
%bar(c,u1), hold,
plot(c,u1,'r*'), hold on
plot(u2,'b*'), 
plot(c,u3,'r*'), hold on
%%
bar(c,mx)



