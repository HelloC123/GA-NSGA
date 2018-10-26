clear
clc

pop_size = 200 ;
n = 10;
m = 3;
k = 4;
Pc = 0.7;
Pm = 0.1;
G = 3000;
Initial_Group = pop(pop_size,n,k,m);

[Initial_Group,fitness_cost,realnum] = decode( Initial_Group,pop_size,n,k,m );
% prob1 = select_prob(pop_size,fitness_cost);
father = father_pair(pop_size);
[children] = cross(father, Initial_Group, Pc,Pm, n, k);
% [children1] = mutation(pop_size,Pm,children, n, k); 
% [species,min0,everage0] = next_pop(pop_size,Initial_Group,children1,n,k,m);
[species,min0,everage0,realnum] = next_pop(pop_size,Initial_Group,children,n,k,m);
 min = zeros(G,1);
   everage =zeros(G,1);
for i = 1:G
    i
%     if i > 500
%         Pm = 0.2;
%     end
%     [prob1] = select_prob(pop_size,fitness_cost1);
    father = father_pair(pop_size);
    [children] = cross(father, species, Pc, Pm, n, k);
%     [children1] = mutation(pop_size,Pm,children, n, k);   
%     [species,min0,everage0] = next_pop(pop_size,species,children1,n,k,m);
    [species,min0,everage0,realnum] = next_pop(pop_size,species,children,n,k,m);
    everage(i,1) = everage0;
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

plot(min(:,1))   
% plot( everage(:,1))   
    
    

