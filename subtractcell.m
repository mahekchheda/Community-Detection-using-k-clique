function R = subtractcell(A)
R = cell(A);
for i =1:length(A)
    x = cell2mat(A(i));
    x = x-1;
    R(i) = mat2cell(x);
end
fprintf('Number of communities -> %d\n',length(R));
celldisp(R);
end