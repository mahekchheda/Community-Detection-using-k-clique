function max_k = max_clique(deg)
%Function used for calculating max clique size that can be present in
%graph.
%Input
% deg -> It is the degree matrix obtained.
%Output
% max_k -> is the value of maximum clique size that can be present.
max_k = 0;
for i=1:length(deg)
    if(deg(i)>=i-1)
        max_k=i;
    else
        break;
    end
end
end