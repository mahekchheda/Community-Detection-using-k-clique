function communities = get_communities(cliques,overlap)
% This function is used to extract communities from the overlap matrix.
% Input:
% cliques -> It represents all the cliques present in the graph.
% overlap -> It is the overlap matrix of cliques.

communities = [];
for i =1:length(cliques)
    % For each clique we find if it has k-1 overlapping nodes with its
    % neighboring clique. If it has then they are merged together in 1
    % component or else it is kept as 1 single component.
    neighbor = find(overlap(i,:)==1);
    components = [];
    for j=1:length(neighbor)
        components = union(components,cliques{neighbor(j)});
    end;
    flag_new = 0;
    % We will check if we have found new components in community
    if ~isempty(components)
        for k=1:length(communities)
            if all(ismember(components,communities{k}))
                flag_new =1;
            end
        end
        
        % If the new component is not in communities then we can add it.
        if flag_new ~=1
            communities = [ communities, {components}]
        end
    end
end