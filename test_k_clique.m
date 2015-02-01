function A = test_k_clique(inp,k)
clearvars M X Y Z R
fid = fopen(inp,'rb');
% Read the graph file and convert the adjacency list to matrix form.
N = fscanf(fid, '%d %d\n', [1,2]);
M = zeros(N(1),N(1));
for x=1:N(2)
    X = fscanf(fid,'%d %d\n',[1,2]);
    % Adding 1 because MATLAB does not support 0 as index vertex so we add
    % 1 here and subtract 1 as it has no consequence on the output or
    % functioning.
    M(X(1)+1,X(2)+1) = 1;
    M(X(2)+1,X(1)+1) = 1;
    M(X(1)+1,X(1)+1) = 1;
end
%disp(M);
% A simple matrix to check functioning of code.
% M = [1 1 0 0 0 0 0 0 0 1;
%      1 1 1 1 1 1 1 0 0 1;
%      0 1 1 1 0 0 1 0 0 0;
%      0 1 1 1 1 1 1 0 0 0;
%      0 1 0 1 1 1 1 1 0 0;
%      0 1 0 1 1 1 1 1 0 0;
%      0 1 1 1 1 1 1 1 1 1;
%      0 0 0 0 1 1 1 1 1 1;
%      0 0 0 0 0 0 1 1 1 1;
%      1 1 0 0 0 0 1 1 1 1];
%      k=4;

A = k_cliques(k,M);

% We subtract the change we made earlier while reading the list into
% matrix.
R = cell(A);
for i =1:length(A)
    x = cell2mat(A(i));
    x = x-1;
    R(i) = mat2cell(x);
end
fprintf('Number of communities -> %d\n',length(R));
celldisp(R);
fclose(fid);
end