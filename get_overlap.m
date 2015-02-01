function overlap = get_overlap(cliques)
% From the cliques we get we will construct a clique overlap matrix as
% shown in the paper.
% Input:
% cliques-> A list of all cliques identified in the graph.
% Output:
% overlap -> An overlap matrix of cliques.
overlap = zeros(length(cliques));
for i=1:length(cliques)
    for j=1:length(cliques)
        if i==j
            overlap(i,j) = numel(cliques{i});
        else
            overlap(i,j) = numel(intersect(cliques{i},cliques{j}));
            overlap(j,i) = overlap(i,j);
        end
    end
end
end