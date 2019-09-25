function p = impPredsort_(A,tcmd)

%%
    p={};
    indices1 = find(A<.1);
    %idxbench = find(A>.05);
    %indices3 = find(imp3<.1);
    %indices4 = find(impCART<.1);
    
    A(indices1) = 0;
    %imp2(indices2) = 0;
    %imp3(indices3) = 0;
    %impCART(indices4) = 0;
    
    if sum(A)==0
        %disp(0)
        p={};
        
    else
    %%
        [rows, columns] = size(A);
        sorted_X = reshape(sort(A(:), 'descend'), [columns, rows])';
    
        if numel( find(A>0) ) >= 3 
            [sortvals, sortidx] = sort(A,'descend');
            sidx=sortidx(1:3);        
            for jx=1:3
                %[p1 idx]= max(imp1);                        % returns "important predictor value" and its "index"
                p{jx} = tcmd.PredictorNames{sidx(jx)};                % finds "predictor name" using the "index"
            end
                    
        else 
            [p idx]= max(A);
            ptemp = tcmd.PredictorNames{idx};
            %disp(ptemp)
            %disp('press key...')
            %pause
            p={ptemp};
            
            
        end
    end
end