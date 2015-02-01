function T = printing_values(cel,k)
    R = cell(0);
    [nrows, ncols] = cellfun(@size, cel)
    for i=1:length(cel)
        if(nrows(i) >= k )
            R = [R ; cel(i)];
        end
    end
    R
    T = table(R);
    writetable(T,'mydata.txt','Delimiter',' ');
end
