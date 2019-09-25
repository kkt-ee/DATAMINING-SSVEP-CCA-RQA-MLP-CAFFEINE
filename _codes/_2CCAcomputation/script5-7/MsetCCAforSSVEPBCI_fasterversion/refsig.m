function y=refsig(f, S, T, N)

% f-- the fundermental frequency
% S-- the sampling rate
% T-- the number of sampling points
% N-- the number of harmonics


for i=1:N
   for j=1:T
    t= j/S;
    y(2*i-1,j)=sin(2*pi*(i*f)*t);
    y(2*i,j)=cos(2*pi*(i*f)*t);
   end
end
