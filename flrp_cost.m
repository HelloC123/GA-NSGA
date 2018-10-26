function [ minmin ] = flrp_cost (pop_size, n, m, k, Pc, Pm, G,No_s)
Initial_Group = pop_cost(pop_size,n,k,m);

[Initial_Group,fitness_cost,realnum] = decode_cost( Initial_Group,pop_size,n,k,m,No_s );
father = father_pair_cost(pop_size);
[children] = cross_cost(father, Initial_Group, Pc,Pm, n, k);
[species,min0,everage0,realnum] = next_pop_cost(pop_size,Initial_Group,children,n,k,m,No_s);
min = zeros(G,1);
for i = 1:G
    i;
%     if i > 500
%         Pm = 0.2;
%     end
    father = father_pair_cost(pop_size);
    [children] = cross_cost(father, species, Pc, Pm, n, k);
    [species,min0,everage0,realnum] = next_pop_cost(pop_size,species,children,n,k,m,No_s);
    min(i,1) = min0;
end
minmin = min(G,1)


end

