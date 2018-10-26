function  f = bi_mean_excess_regret_cost( obj_cost,real_num,z ,n,min_cost, min_time)

demand = [30	18	5	28	35	29	36	7	35	7	10	13	11	9	5	31	10	8	5	33
8	22	33	7	20	17	15	32	20	29	34	16	16	28	35	27	32	33	12	32
23	14	29	8	32	12	18	34	31	36	7	8	28	36	31	29	6	31	30	24
35	20	32	32	16	17	7	19	34	34	17	31	35	12	32	26	30	7	17	15
35	31	8	14	21	32	10	33	36	36	32	13	16	34	21	33	27	30	16	8
22	36	30	10	23	30	31	20	20	18	31	22	34	32	30	7	32	31	32	15
33	36	25	29	32	23	35	30	31	33	12	35	16	35	26	36	6	35	33	29
19	35	32	33	9	36	22	31	8	30	32	25	34	11	31	33	32	15	30	31
34	34	19	32	33	9	35	25	34	32	16	33	14	36	35	33	34	18	35	36
33	18	32	36	36	33	33	31	14	12	31	36	30	26	8	31	30	30	33	35

];

more = 300;
less = 500;


prob3 = [0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
% min_cost = [14368	14251 14260 14449 14890 14449 15380 14881 14449 14962 ];
regret_cost = zeros(1,z);
prob4 = zeros(1,z);

for i = 1:z
    chengfa4 = 0;
    for d = 1:n
        chengfa4 = chengfa4 + more * max(real_num(1,d)-demand(i,d),0) + less * max(demand(i,d)-real_num(1,d),0);     %物资过量短缺惩罚
    end
    regret_cost(i) = obj_cost + chengfa4 - min_cost(i);
end
[regret_cost1,index1] = sort(regret_cost);
for j = 1:z
   prob4(j) = prob3(index1(j));
end

sum1 = 0;
sum2 = 0;
sum3 =0;
reliability = 0.8;
for a = 1: z
    sum1 = sum2;
    sum2 = sum2 + prob3(a);
    if reliability >= sum1 && reliability < sum2
        unique_index = a;
        break
    end
   
end
regret_cost2 =zeros(1,z-unique_index+1);
for b = 1:z-unique_index+1
    regret_cost2(b) = regret_cost1(unique_index-1+b);
    if b == 1
       prob5(b) = sum2 -  reliability;
    else
       prob5(b) = prob4(unique_index-1+b); 
    end
    sum3 = sum3 + prob5(b);
end
f=0;
for c = 1:z-unique_index+1
   prob6(c) = prob5(c)/sum3; 
   f = f + regret_cost2(c) * prob6(c);
   
   
end







end



