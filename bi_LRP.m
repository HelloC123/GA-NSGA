clear
clc

pop_size =100 ;
n = 10;
m = 3;
k = 4;
Pc = 0.9;
Pm = 0.02;
G = 2000;

Initial_Group = pop(pop_size,n,k,m);
[Initial_Group,~,~] = decode( Initial_Group,n,k,m );
Group = non_dorminated_sort(Initial_Group,  n, k );
for i = 1 : G
    i
%     if i > 300
%         Pm = 0.5;
%     end
    pool = round(pop_size/2);
    tour = 2;   
    father = tournament_selection(Group, pool, tour);
    children = cross(father,n,k,m);
    children1 = mutation( pop_size, Pm, children, n, k,m);
    Group = next_pop(Group, children1,pop_size,n,k);
end
plot(Group(:,2*n+k+5*n+1),Group(:,2*n+k+5*n+2),'*');













    
    

