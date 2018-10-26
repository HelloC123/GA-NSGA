 function [species,min0,everage0,realnum] = next_pop_cost(pop_size,Group1,Group2,n,k,m,No_s)
species = zeros(size(Group1));
fitness_cost1 = zeros(size(Group1,1),1);
obj_cost = zeros(size(Group1,1),1);
[Group2,~,realnum] = decode_cost(Group2,pop_size,n,k,m,No_s);
family = zeros(size(Group1,1)+size(Group2,1),size(Group1,2));
for i = 1:size(Group1,1)
   family(i,:) = Group1(i,:);
end
for j = 1:size(Group2,1)
   family(size(Group1,1)+j,:) = Group2(j,:);
end
family1 = sortrows(family,size(family,2));
obj_cost = family1(:,2*n+k+5*n+1);
aa = min(obj_cost);
aaa = max(obj_cost);
% c = everage/(everage-aa);
% cc = -aa*everage/(everage-a);
for b = 1:size(family1,1)
   fitness_cost1(b) = aaa-obj_cost(b)+1; 
end
prob1 = select_prob_cost( 2*pop_size,fitness_cost1);
for a = 1:50
   species(a,:) = family1(a,:) ;
%    fitness_cost1(a,1) = 1/species(a,2*n+k+5*n+1) ;
   obj_cost(a,1) = species(a,2*n+k+5*n+1);
end

for a =51:pop_size
   g = select_father_cost( 2*pop_size, prob1 );
   species(a,:) = family1(g,:) ;    
end

aa = min(species(:,2*n+k+5*n+1));
aaa = max(species(:,2*n+k+5*n+1));
everage = mean(species(:,2*n+k+5*n+1));
% c = everage/(everage-aa);
% cc = -aa*everage/(everage-a);
% for b = 1:pop_size
%    fitness_cost1(b) = aaa-obj_cost(b)+1; 
% end


min0 = aa;
everage0 = everage;




end

