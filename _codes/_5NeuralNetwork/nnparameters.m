%% [SUPPORTING] fn
% STEP 4: -NEURAL NETWORK-
%                  ...MLP
%       fUNCTION CREATES A TABLE OF ALL POSSIBLE COMBINATIONS NEURAL NETWORK PARAMETERS
%                               ...COMBINATIONS OF <TRAINfn> <ACTfn1> <ACTfn2> <ERRfn>

%       Returns prameters < NNparam > which needs to be plugged to NN
%                                      ---To be called in main() for : 
%                                                          < NNparam >
%                      ---in nnmlp(xlsxfile,impPredictors,a,b,NNparam)


%% supporting fUNCTION : nnparameters()
function T=nnparameters(TRAINfn,ACTfn1,ACTfn2,ERRfn)

T=table();    
for j=1:length(TRAINfn)
    for k=1:length(ACTfn1)
        for l=1:length(ACTfn2)
            for m=1:length(ERRfn)
                x = {TRAINfn{1,j} , ACTfn1{1,k}, ACTfn2{1,l}, ERRfn{1,m}};
                T=[T;x];
                %fprintf("%d %d %d %d %d",i,j,k,l,m)
                %disp({TRAINfn{1,j} , ACTfn1{1,k}, ACTfn2{1,l}, ERRfn{1,m}})
            end          
        end
    end
end
T.Properties.VariableNames = {'trainfn','actfn1','actfn2','errfn'};
end
