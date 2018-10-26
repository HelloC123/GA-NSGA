function [ species,min0,everage0] = time_next_pop(pop_size,Group1, Group2,n,k,m )

species = zeros(size(Group1));
fitness_time1 = zeros(size(Group1,1),1);
obj_time = zeros(size(Group1,1),1);
[Group2,~] = time_decode(Group2,pop_size,n,k,m);
family = zeros(size(Group1,1)+size(Group2,1),size(Group1,2));
for i = 1:size(Group1,1)
   family(i,:) = Group1(i,:);
end
for j = 1:size(Group2,1)
   family(size(Group1,1)+j,:) = Group2(j,:);
end
family1 = sortrows(family,size(family,2));
obj_time = family1(:,2*n+k+5*n+1);
aa = min(obj_time);
aaa = max(obj_time);
% c = everage/(everage-aa);
% cc = -aa*everage/(everage-a);
for b = 1:size(family1,1)
   fitness_time1(b) = aaa-obj_time(b)+1; 
end
prob1 = time_select_prob( 2*pop_size,fitness_time1);
for a = 1:20
   species(a,:) = family1(a,:) ;
%    fitness_cost1(a,1) = 1/species(a,2*n+k+5*n+1) ;
   obj_time(a,1) = species(a,2*n+k+5*n+1);
end

for a =21:pop_size
   g = time_select_father( 2*pop_size, prob1 );
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
















% family = zeros(size(Group1,1)+size(Group2,1),size(Group1,2));
% for i = 1:size(Group1,1)
%    family(i,:) = Group1(i,:);
% end
% for j = 1:size(Group2,1)
%    family(size(Group1,1)+j,:) = Group2(j,:);
% end
% 
% [ family,obj_time,fitness_time] = decode(family(size(Group1,1)+1:size(Group1,1)+size(Group2,1),:),pop_size,n,k,m);
% [~,index] = sort(fitness_time);
% for a = 1:pop_size
%    species(a,:) = family(index(size(family,1)+1-a),:) ;
% end
% min0 = min(obj_time);
% 
% species = zeros(size(Group1));
% fitness_time1 = zeros(pop_size,1);
% total_time = zeros(pop_size,1);
% [Group2,~] = decode(Group2,pop_size,n,k,m);
% family = zeros(size(Group1,1)+size(Group2,1),size(Group1,2));
% for i = 1:size(Group1,1)
%    family(i,:) = Group1(i,:);
% end
% for j = 1:size(Group2,1)
%    family(size(Group1,1)+j,:) = Group2(j,:);
% end
% family1 = sortrows(family,size(family,2));
% for a = 1:pop_size
%    species(a,:) = family1(a,:) ;
%    fitness_time1(a,1) = 1/species(a,2*n+k+5*n+1) ;
%    total_time(a,1) = species(a,2*n+k+5*n+1);
% end
% 
% min0 = species(1,size(species,2));
% z = mean(total_time);

% [species,fitness_time1,index01,index02] = decode( Group2,pop_size,n,k,m );
% if species(index01(1,1),2*n+k+1+5*n) > Group1(index1(1,1),2*n+k+1+5*n)
%      for i =1:size(index02,2)
%         species(index02(i),:) = Group1(index1(1,1),:);
%     end
% end
% min0 = min(species(:,2*n+k+5*n+1));
% index01 = find(species(:,2*n+k+1+5*n)== min0);



