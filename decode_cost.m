function [Group, fitness_cost, realnum] = decode_cost( Group,pop_size,n,k,m,No_s )
low = 5;
up = 36;
b = (up-low)/(2^5-1);
M = 100000;
timewindow = [126;139;160;105;120;120;112;102;101;156;103;180;105;119;102;111;104;130;157;117];
load = [100;100;100;100;100;150;150;150;150;150];
storage = [500;400;600];
DC_fixcost = [20000;10000;30000];
car_fixcost = [400;400;400;400;400;500;500;500;500;500];
unit_cost = 1;
more = 300;
less = 500;
travel_time = [0 	20 	15 	21 	16 	7 	6 	18 	15 	21 	19 	21 	21 	11 	10 	17 	11 	15 	18 	12 	11 	13 	12 
20 	0 	14 	12 	17 	18 	20 	17 	18 	6 	6 	7 	12 	17 	21 	9 	17 	12 	16 	23 	15 	21 	16 
15 	14 	0 	12 	8 	13 	15 	20 	19 	15 	14 	14 	11 	9 	13 	10 	16 	7 	9 	14 	14 	12 	8 
21 	12 	12 	0 	14 	20 	21 	23 	23 	13 	13 	12 	6 	16 	20 	11 	21 	12 	11 	21 	18 	19 	15 
16 	17 	8 	14 	0 	15 	15 	23 	21 	18 	17 	17 	12 	10 	12 	14 	18 	10 	8 	13 	16 	10 	10 
7 	18 	10 	20 	15 	0 	7 	16 	14 	19 	17 	19 	19 	10 	10 	15 	10 	13 	17 	13 	9 	13 	10 
6 	20 	15 	21 	15 	7 	0 	18 	15 	21 	20 	21 	21 	11 	10 	17 	11 	15 	18 	12 	11 	12 	11 
18 	17 	20 	23 	23 	16 	18 	0 	8 	16 	16 	17 	23 	19 	22 	17 	12 	18 	24 	24 	13 	24 	19 
15 	18 	19 	23 	21 	14 	15 	8 	0 	17 	16 	18 	22 	17 	19 	16 	9 	17 	23 	21 	11 	21 	17 
21 	6 	15 	13 	18 	19 	21 	16 	17 	0 	6 	6 	14 	17 	22 	10 	17 	13 	18 	24 	15 	22 	17 
19 	6 	14 	13 	17 	17 	20 	16 	16 	6 	0 	7 	13 	16 	21 	8 	16 	12 	17 	23 	14 	21 	15 
21 	7 	14 	12 	17 	19 	21 	17 	18 	6 	7 	0 	12 	17 	21 	9 	18 	13 	16 	23 	16 	21 	16 
21 	12 	11 	6 	12 	19 	21 	23 	22 	14 	13 	12 	0 	15 	19 	11 	20 	11 	10 	20 	18 	18 	14 
11 	17 	9 	16 	10 	10 	11 	19 	17 	17 	16 	17 	15 	0 	9 	13 	13 	10 	13 	11 	11 	10 	6 
10 	21 	13 	20 	12 	10 	10 	22 	19 	22 	21 	21 	19 	9 	0 	18 	15 	14 	15 	7 	14 	8 	10 
17 	9 	11 	11 	14 	15 	17 	17 	16 	10 	8 	9 	11 	13 	18 	0 	15 	9 	14 	19 	13 	17 	12 
11 	17 	16 	21 	18 	10 	11 	12 	9 	17 	16 	18 	20 	13 	15 	15 	0 	14 	20 	17 	7 	17 	13 
15 	12 	7 	12 	10 	13 	15 	18 	17 	13 	12 	13 	11 	10 	14 	9 	14 	0 	11 	16 	12 	14 	9 
18 	16 	9 	11 	8 	17 	18 	24 	23 	18 	17 	16 	10 	13 	15 	14 	20 	11 	0 	16 	18 	13 	12 
12 	23 	14 	21 	13 	13 	12 	24 	21 	24 	23 	23 	20 	11 	7 	19 	17 	16 	16 	0 	16 	8 	12 
11 	15 	14 	18 	16 	9 	11 	13 	11 	15 	14 	16 	18 	11 	14 	13 	7 	12 	18 	16 	0 	16 	11 
13 	21 	12 	19 	10 	13 	12 	24 	21 	22 	21 	21 	18 	10 	8 	17 	17 	14 	13 	8 	16 	0 	11 
12 	16 	8 	15 	10 	10 	11 	19 	17 	17 	15 	16 	14 	6 	10 	12 	13 	9 	12 	12 	11 	11 	0 
];

dis = [0	684	441	738	477	90	18	567	441	702	648	702	702	261	225	540	261	432	603	315	261	342	297
684	0	414	315	549	594	693	540	567	63	54	18	333	522	729	162	549	333	513	810	459	720	486
441	414	0	315	144	369	432	684	630	468	405	423	270	189	360	261	486	99	189	423	387	324	144
738	315	315	0	387	657	738	810	792	378	351	315	45	495	675	288	711	315	279	729	603	621	450
477	549	144	387	0	432	468	819	738	603	549	558	333	225	324	405	585	243	135	360	486	243	207
90	594	369	657	432	0	99	513	396	612	558	612	621	207	243	450	216	351	540	342	189	342	234
18	693	432	738	468	99	0	576	459	711	657	711	702	252	216	540	279	432	594	297	279	324	288
567	540	684	810	819	513	576	0	126	504	486	558	801	630	756	522	306	594	864	855	342	837	621
441	567	630	792	738	396	459	126	0	540	513	576	783	540	648	513	189	540	810	738	252	729	540
702	63	468	378	603	612	711	504	540	0	54	63	396	558	756	207	540	378	567	846	459	765	522
648	54	405	351	549	558	657	486	513	54	0	72	360	504	702	144	495	315	522	792	414	711	459
702	18	423	315	558	612	711	558	576	63	72	0	333	540	738	180	567	342	513	828	477	738	495
702	333	270	45	333	621	702	801	783	396	360	333	0	450	630	279	684	279	234	684	576	576	414
261	522	189	495	225	207	252	630	540	558	504	540	450	0	198	360	369	207	342	288	288	216	45
225	729	360	675	324	243	216	756	648	756	702	738	630	198	0	567	459	405	468	99	414	126	243
540	162	261	288	405	450	540	522	513	207	144	180	279	360	567	0	441	171	387	648	342	558	324
261	549	486	711	585	216	279	306	189	540	495	567	684	369	459	441	0	423	675	558	108	549	378
432	333	99	315	243	351	432	594	540	378	315	342	279	207	405	171	423	0	270	486	315	387	162
603	513	189	279	135	540	594	864	810	567	522	513	234	342	468	387	675	270	0	495	567	378	315
315	810	423	729	360	342	297	855	738	846	792	828	684	288	99	648	558	486	495	0	513	117	333
261	459	387	603	486	189	279	342	252	459	414	477	576	288	414	342	108	315	567	513	0	486	288
342	720	324	621	243	342	324	837	729	765	711	738	576	216	126	558	549	387	378	117	486	0	252
297	486	144	450	207	234	288	621	540	522	459	495	414	45	243	324	378	162	315	333	288	252	0];


all_demand = [30	18	5	28	35	29	36	7	35	7	10	13	11	9	5	31	10	8	5	33
8	22	33	7	20	17	15	32	20	29	34	16	16	28	35	27	32	33	12	32
23	14	29	8	32	12	18	34	31	36	7	8	28	36	31	29	6	31	30	24
35	20	32	32	16	17	7	19	34	34	17	31	35	12	32	26	30	7	17	15
35	31	8	14	21	32	10	33	36	36	32	13	16	34	21	33	27	30	16	8
22	36	30	10	23	30	31	20	20	18	31	22	34	32	30	7	32	31	32	15
33	36	25	29	32	23	35	30	31	33	12	35	16	35	26	36	6	35	33	29
19	35	32	33	9	36	22	31	8	30	32	25	34	11	31	33	32	15	30	31
34	34	19	32	33	9	35	25	34	32	16	33	14	36	35	33	34	18	35	36
33	18	32	36	36	33	33	31	14	12	31	36	30	26	8	31	30	30	33	35];

demand = all_demand(No_s,:);



obj_cost = zeros(size(Group,1),1);
fitness_cost = zeros(size(Group,1),1);
for i =1:pop_size
    for j = 1:n
       real_num(i,j) = low + b*(2^4*Group(i,2*n+k+1+5*(j-1))+2^3*Group(i,2*n+k+2+5*(j-1))+2^2*Group(i,2*n+k+3+5*(j-1))+2^1*Group(i,2*n+k+4+5*(j-1))+2^0*Group(i,2*n+k+5+5*(j-1)))  ; 
    end
end
for i =1:pop_size
    for j = 1:n
       realnum(i,j) = real_num(i,j); 
    end
end

node = cell(k,1);
for i = 1:pop_size
    total_cost = 0;
    chengfa1 = 0;
    chengfa2 = 0;
    chengfa3 = 0;
    chengfa4 = 0;
    weigh = zeros(1,k);
   
    for w = 1:n
       chengfa4 = chengfa4 + more * max(real_num(i,w)-demand(1,w),0) + less * max(demand(1,w)-real_num(i,w),0) ;  %物资过量短缺惩罚
    end
    
    for a = 1:k
       node{a,1} = find(Group(i,1:n)==a);
       if size(node{a,1},2) > 0
           total_cost = total_cost + car_fixcost(a);
           s = Group(i,2*n+a);
           arrive_time = travel_time(s,m+Group(i,n+node{a,1}(1,1)))  ;    %第一个需求点时间
           length = dis(s,m+Group(i,n+node{a,1}(1,1)));
           if arrive_time > timewindow(Group(i,n+node{a,1}(1,1)))
               chengfa2 = M;
           end
           weigh(1,a) = real_num(i,Group(i,n+node{a,1}(1,1)));     %第一个需求点送达量
           if weigh(1,a) > load(a)
               chengfa1 = M;
           end
           
           for b = 2:size(node{a,1},2)
               arrive_time = arrive_time + travel_time(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
               if arrive_time > timewindow(Group(i,n+node{a,1}(1,b)))
                   chengfa2 = M                ;        %时间窗惩罚
               end
               length = length + dis(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
               
               weigh(1,a) = weigh(1,a) + real_num(i,Group(i,n+node{a,1}(1,b)));
               if weigh(1,a) > load(a)
                  chengfa1 = M;                     %车辆超载惩罚
               end
               
           end
           length = length + dis(m+Group(i,n+node{a,1}(1,size(node{a,1},2))),s);
       else
           continue
       end   
       total_cost = total_cost + unit_cost * length;   
    end
    
% 一个点 10.9
%     for a = 1:k
%        node{a,1} = find(Group(i,1:n)==a);
%        if size(node{a,1},2) > 1
%            total_cost = total_cost + car_fixcost(a);
%            s = Group(i,2*n+a);
%            arrive_time = travel_time(s,m+Group(i,n+node{a,1}(1,1)))  ;    %第一个需求点时间
%            length = dis(s,m+Group(i,n+node{a,1}(1,1)));
%            if arrive_time > timewindow(Group(i,n+node{a,1}(1,1)))
%                chengfa2 = M;
%            end
%            weigh(1,a) = real_num(i,Group(i,n+node{a,1}(1,1)));     %第一个需求点送达量
%            if weigh(1,a) > load(a)
%                chengfa1 = M;
%            end
%            
%            for b = 2:size(node{a,1},2)
%                arrive_time = arrive_time + travel_time(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
%                if arrive_time > timewindow(Group(i,n+node{a,1}(1,b)))
%                    chengfa2 = M                ;        %时间窗惩罚
%                end
%                length = length + dis(m+Group(i,n+node{a,1}(1,b-1)),m+Group(i,n+node{a,1}(1,b)));
%                
%                weigh(1,a) = weigh(1,a) + real_num(i,Group(i,n+node{a,1}(1,b)));
%                if weigh(1,a) > load(a)
%                   chengfa1 = M;                     %车辆超载惩罚
%                end    
%            end
%            length = length + dis(m+Group(i,n+node{a,1}(1,size(node{a,1},2))),s);
%        elseif size(node{a,1},2) == 1
%            total_cost = total_cost + car_fixcost(a);
%            s = Group(i,2*n+a);
%            arrive_time = travel_time(s,m+Group(i,n+node{a,1}(1,1)))  ;    %第一个需求点时间
%            length = dis(s,m+Group(i,n+node{a,1}(1,1)));
%            if arrive_time > timewindow(Group(i,n+node{a,1}(1,1)))
%                chengfa2 = M;
%            end
%            weigh(1,a) = real_num(i,Group(i,n+node{a,1}(1,1)));     %第一个需求点送达量
%            if weigh(1,a) > load(a)
%                chengfa1 = M;
%            end
%            length = length + dis(m+Group(i,n+node{a,1}(1,size(node{a,1},2))),s);    
%        else
%            continue
%        end   
%        total_cost = total_cost + unit_cost * length;   
%     end




    car = cell(m,1);
    for c = 1:m
       capacity = 0;
       car{c,1} = find(Group(i,2*n+1:2*n+k)==c) ;
       if size(car{c,1},2) > 0
          for d = 1:size(car{c,1},2)
             capacity = capacity + weigh(car{c,1}(1,d)); 
          end
          if capacity > storage(c)
              chengfa3 = M;          %库容惩罚
          end
          
          select_DC = intersect(Group(i,1:n),car{c,1});
          if size(select_DC,2) > 0
              total_cost = total_cost + DC_fixcost(c);
          end
       else
           continue
       end
    end     
    obj_cost(i) = total_cost + chengfa3 + chengfa1 + chengfa2 + chengfa4;
    Group(i,2*n+k+1+5*n) = obj_cost(i);
end
aa = min(obj_cost);
aaa = max(obj_cost);
everage = mean(Group(:,2*n+k+5*n+1));
for b = 1:pop_size
    fitness_cost(b) = aaa - obj_cost(b) + 1 ;
    if fitness_cost(b) < 0
        fitness_cost(b) = 0;
    end
end
end

