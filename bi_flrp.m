function [ Group,size_father,size_children,size_Group,iteration_solution] = bi_flrp (pop_size, n, m, k, Pc, Pm, G, min_cost, min_time)
Initial_Group = bi_pop(pop_size,n,k,m);
[Initial_Group,~,~] = bi_decode( Initial_Group,n,k,m,min_cost, min_time );
Group = bi_non_dorminated_sort(Initial_Group,  n, k );
for i = 1 : G
    i;
    pool = round(pop_size/2);
    tour = 2;   
    father = bi_tournament_selection(Group, pool, tour);
    size_father=size(father,1);
    children = bi_cross(father,n,k,m,Pc,min_cost, min_time);
    size_children(1,i) = size(children,1);
%     children1 = bi_mutation( pop_size, Pm, children, n, k,m);
%     Group = bi_next_pop(Group, children1,pop_size,n,k);
    Group = bi_next_pop(Group, children,pop_size,n,k);
    size_Group(1,i) = size(Group,1);
    iteration_solution {1,i} = Group;
end


end

