function [communities] = k_cliques(k,M)
% k-clique algorithm for detecting overlapping communities in a network 
% as defined in the paper "Uncovering the overlapping 
% community structure of complex networks in nature and society" - 
% G. Palla, I. Derényi, I. Farkas, and T. Vicsek - Nature 435, 814–818 (2005)
% Inputs: 
% k - clique size 
% A - adjacency matrix
% 
% Outputs: 
% X - detected communities 
% Y - all cliques (i.e. complete subgraphs that are not parts of larger
% complete subgraphs)
% Z - k-clique matrix

% Finding number of nodes in the given matrix
[m, n] = size(M);
deg = zeros(0,m);
for i=1:m
    t=0;
    for j=1:n
        if(M(i,j)==1)
            t = t+1;
        end
    end
    deg(i) = t-1;
end
deg = sort(deg, 'descend');
% Finding maximum possible clique size for the given graph
max_k = max_clique(deg);

%Finding all the cliques in the graph starting from max_k to 3.
cliques = get_cliques(M,m,max_k);
%celldisp(cliques);

% From the cliques we get we will construct a clique overlap matrix as
% shown in the paper.
overlap = get_overlap(cliques);

% To find k-cliques from the overalp matrix that we get we will subtract k
% from the diagnol elements and k-1 from the non-diagnol elements.
overlap = overlap - k +1;
for i=1:length(cliques)
    overlap(i,i) = overlap(i,i)-1;
end
overlap(overlap >= 0) = 1;
overlap(overlap < 0) = 0;

% We need to extract out the communities.
communities = get_communities(cliques,overlap);
% To display all the communities
%celldisp(communities);

end