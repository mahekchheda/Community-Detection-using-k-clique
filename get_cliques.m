function cliques = get_cliques(M,nodes,max_k)
% This function works according to the algorithm 1.1.2
% Input:
% M -> Is the adjacency matrix of the graph
% num-> Is the number of nodes.
% max-> Maximum clique size that can be present.
%
% Output:
% cliques -> A list of cliques that is obtained from the graph.

cliques = cell(0);
% Find all s-size kliques in the graph
for s = max_k:-1:2
    %disp(s)
    M_aux = M;
    % Looping over nodes
    for n = 1:nodes
        X = n; % Set of nodes all linked to each other
        Y = setdiff(find(M_aux(n,:)==1),n); % Set of nodes that are linked to each node in A, but not necessarily to the nodes in B
        Z = merge_sets(X,Y,s,M_aux); % Enlarging A by transferring nodes from B
        if ~isempty(Z)
            for i = size(Z,1)
                cliques = [cliques;{Z(i,:)}];
            end
        end
        M_aux(n,:) = 0; % Remove the processed node
        M_aux(:,n) = 0;
    end
end
function S = merge_sets(X,Y,max_k,M_tem)
        % First let us find if X or X U Y is subset of a previously found
        % bigger clique.
        s1 = 0;
        s12 = 0;
        for i = 1:length(cliques)
            for j = 1:size(cliques{i},1)
                if all(ismember(X,cliques{i}(j,:)))
                    s1 = 1;
                end
                if all(ismember(union(X,Y),cliques{i}(j,:)))
                    s12 = 1;
                    break;
                end
            end
        end
         if s12==1 || (length(X) ~= max_k && isempty(Y))
             S = [];  % Union can be included in the clique matrix
         elseif length(X) == max_k
             % IF X is large enough for clique size of max. But it might
             % already be present in clique matrix hence, we need to check
             % that
             if s1==1
                 S = []; % X is already present in cliques
             else
                 S = X; % X is not present and hence included in cliques.
             end
         else
            % Check the remaining possible combinations of the neighbors
            % indices
            R = Y >=max(X); 
            % Here we look for next neighbour of last element of X present 
            % in Y. Since we are going in increasing order we can directly
            % compare the max value reached in X to that of Y. If there
            % exists a value greater than X in Y then we know there are
            % neighbours which we need to process.
            
            if isempty(find(R,1))
                S = [];
            else
                S = [];
                for a = find(R,1): length(Y)
                    x = X;
                    y = Y;
                    x = [x y(a)];
                    y = setdiff(y(M_tem(Y(a),y)==1),y(a));
                    A = merge_sets(x,y,max_k, M_tem);
                    S = [S ; A];
                end
            end
         end
    end
end