function T = printing_values(cel)
    T = table(cel');
    writetable(T,'mydata.txt','Delimiter',' ');
end
