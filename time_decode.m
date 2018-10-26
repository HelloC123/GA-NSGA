function [Group, fitness_time] = decode( Group,pop_size,n,k,m )
low = 5;
up = 36;
b = (up-low)/(2^5-1);
M = 1000000000;
timewindow = [126;139;160;105;120;120;112;102;101;156;103;180;105;119;102;111;104;130;157;117];
load = [100;100;100;100;100;100;100;100;100;100];
storage = [500;400;600];
DC_fixcost = [20000;10000;30000];
car_fixcost = [400;400;400;400;400;500;500;500;500;500];
unit_cost = 9;
more = 300;
less = 500;
travel_time = [0	20	15	21	16	7	6	18	15	21	19	21	21	11	10	17	11	15	18	12
20	0	14	12	17	18	20	17	18	6	6	7	12	17	21	9	17	12	16	23
15	14	0	12	8	13	15	20	19	15	14	14	11	9	13	10	16	7	9	14
21	12	12	0	14	20	21	23	23	13	13	12	6	16	20	11	21	12	11	21
16	17	8	14	0	15	15	23	21	18	17	17	12	10	12	14	18	10	8	13
7	18	10	20	15	0	7	16	14	19	17	19	19	10	10	15	10	13	17	13
6	20	15	21	15	7	0	18	15	21	20	21	21	11	10	17	11	15	18	12
18	17	20	23	23	16	18	0	8	16	16	17	23	19	22	17	12	18	24	24
15	18	19	23	21	14	15	8	0	17	16	18	22	17	19	16	9	17	23	21
21	6	15	13	18	19	21	16	17	0	6	6	14	17	22	10	17	13	18	24
19	6	14	13	17	17	20	16	16	6	0	7	13	16	21	8	16	12	17	23
21	7	14	12	17	19	21	17	18	6	7	0	12	17	21	9	18	13	16	23
21	12	11	6	12	19	21	23	22	14	13	12	0	15	19	11	20	11	10	20
11	17	9	16	10	10	11	19	17	17	16	17	15	0	9	13	13	10	13	11
10	21	13	20	12	10	10	22	19	22	21	21	19	9	0	18	15	14	15	7
17	9	11	11	14	15	17	17	16	10	8	9	11	13	18	0	15	9	14	19
11	17	16	21	18	10	11	12	9	17	16	18	20	13	15	15	0	14	20	17
15	12	7	12	10	13	15	18	17	13	12	13	11	10	14	9	14	0	11	16
18	16	9	11	8	17	18	24	23	18	17	16	10	13	15	14	20	11	0	16
12	23	14	21	13	13	12	24	21	24	23	23	20	11	7	19	17	16	16	0
11	15	14	18	16	9	11	13	11	15	14	16	18	11	14	13	7	12	18	16
13	21	12	19	10	13	12	24	21	22	21	21	18	10	8	17	17	14	13	8
12	16	8	15	10	10	11	19	17	17	15	16	14	6	10	12	13	9	12	12];
% demand = [5,20,30,10,36,20,20,10,15,20,30,35,27,10,10,20,30,5,25,30];




obj_time = zeros(pop_size,1);
fitness_time = zeros(pop_size,1);
for i =1:pop_size
    for j = 1:n
       real_num(i,j) = low + b*(2^4*Group(i,2*n+k+1+5*(j-1))+2^3*Group(i,2*n+k+2+5*(j-1))+2^2*Group(i,2*n+k+3+5*(j-1))+2^1*Group(i,2*n+k+4+5*(j-1))+2^0*Group(i,2*n+k+5+5*(j-1)));
    end
end
node = cell(k,1);
for i = 1:pop_size
    total_time = 0;
    chengfa1 = 0;
    chengfa2 = 0;
    chengfa3 = 0;
%     chengfa4 = 0;
    weigh = zeros(1,k);
   
%     for w = 1:n
%        chengfa4 = chengfa4 + more * max(real_num(i,w)-demand(1,w),0) + less * max(demand(1,w)-real_num(i,w),0)       %物资过量短缺惩罚
%     end
    
    for a = 1:k
       node{a,1} = find(Group(i,1:n)==a);
       if size(node{a,1},2) > 0
           s = Group(i,2*n+a);
           arrive_time = travel_time(s,m+Group(i,n+node{a,1}(1,1)))  ;    %第一个需求点时间
           route_time = size(node{a,1},2) * travel_time(s,m+Group(i,n+node{a,1}(1,1)));
           if arrive_time > timewindow(Group(i,n+node{a,1}(1,1)))
               chengfa2 = M;
           end
           weigh(1,a) = real_num(node{a,1}(1,1))  ;    %第一个需求点送达量
           if weigh(1,a) > load(a)
               chengfa1 = M;
           end
           for b = 2:size(node{a,1},2)
               arrive_time = arrive_time + travel_time(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
               if arrive_time > timewindow(Group(i,n+node{a,1}(1,b)))
                   chengfa2 = M                  ;        %时间窗惩罚
               end
               route_time = route_time + (size(node{a,1},2)+1-b)* travel_time(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
               
               weigh(1,a) = weigh(1,a) + real_num(Group(i,n+node{a,1}(1,b)));
               if weigh(1,a) > load(a)
                  chengfa1 = M              ;           %车辆超载惩罚
               end
               
           end
       else
           continue
       end   
       total_time = total_time + route_time + chengfa1 + chengfa2  ;
    end
    
    car = cell(m,1);
    for c = 1:m
        capacity = 0;
       car{c,1} = find(Group(i,2*n+1:2*n+k)==c) ;
       if size(car{c,1},2) > 0
          for d = 1:size(car{c,1},2)
             capacity = capacity + weigh(car{c,1}(1,d)) ;
          end
          if capacity > storage(c)
              chengfa3 = M      ;     %库容惩罚
          end
       end
    end
    
    
    
    obj_time(i) = total_time + chengfa3;
     Group(i,2*n+k+1+5*n) = obj_time(i);
%     fitness_time(i) = 1/obj_time(i);
end
aa = min(obj_time);
aaa = max(obj_time);
for b = 1:pop_size
    fitness_time(b) = aaa - obj_time(b)+1;
    
end
end

