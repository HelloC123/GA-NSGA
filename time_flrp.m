function [ minmin ] = time_flrp (pop_size, n, m, k, Pc, Pm, G,NO_s)
Initial_Group = time_pop(pop_size,n,k,m);

[Initial_Group,fitness_cost] = time_decode( Initial_Group,pop_size,n,k,m );
% prob1 = select_prob(pop_size,fitness_cost);
father = time_father_pair(pop_size);
[children] = time_cross(father, Initial_Group, Pc,Pm, n, k);
% [children1] = mutation(pop_size,Pm,children, n, k); 
% [species,min0,everage0] = next_pop(pop_size,Initial_Group,children1,n,k,m);
[species,min0,everage0] = time_next_pop(pop_size,Initial_Group,children,n,k,m);
 min = zeros(G,1);
   everage =zeros(G,1);
for i = 1:G
    i;
%     if i > 500
%         Pm = 0.2;
%     end
%     [prob1] = select_prob(pop_size,fitness_cost1);
    father = time_father_pair(pop_size);
    [children] = time_cross(father, species, Pc, Pm, n, k);
%     [children1] = mutation(pop_size,Pm,children, n, k);   
%     [species,min0,everage0] = next_pop(pop_size,species,children1,n,k,m);
    [species,min0,everage0] = time_next_pop(pop_size,species,children,n,k,m);
    
          min(i,1) = min0;
end
%最佳个体保留+轮盘赌
% for i = 1:G
%      i
%     prob1 = select_prob(pop_size,fitness_cost1);
%     father = father_pair(pop_size, prob1,Pc);
%     [children] = cross(pop_size,father, species, Pc, n, k);
%     [children1] = mutation(pop_size,Pm,children, n, k); 
%     [species,min0,everage0,fitness_cost1,index01] = next_pop(species,children1,pop_size,n,k,m ,index01);
%    min(i,1) = min0;
%    everage(i,1) = everage0;
% end
minmin = min(G,1)
% plot(min(:,1))   

end

