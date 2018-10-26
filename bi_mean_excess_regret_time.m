function  f = bi_mean_excess_regret_time( obj_time,z,min_cost, min_time )
f = 0;

prob3 = [0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1;0.1];
% min_time = [144 144 144 144 144 144 144 144 144 144 ];
regret_time = zeros(1,z);
prob4 = zeros(1,z);
for i = 1:z
    regret_time(i) = obj_time - min_time(i);
end
[regret_time1,index1] = sort(regret_time);
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
regret_time2 =zeros(1,z-unique_index+1);
for b = 1:z-unique_index+1
    regret_time2(b) = regret_time1(unique_index-1+b);
    if b == 1
       prob5(b) = sum2 -  reliability;
    else
       prob5(b) = prob4(unique_index-1+b); 
    end
    sum3 = sum3 + prob5(b);
end

for c = 1:z-unique_index+1
   prob6(c) = prob5(c)/sum3; 
   f = f + regret_time2(c) * prob6(c);
   
   
end







end

