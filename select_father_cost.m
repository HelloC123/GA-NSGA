function [ father ] = select_father_cost( pop_size, prob1 )
sum1 = 0;
sum2 = 0;
a = rand(1);
for i = 1: pop_size
    sum1 = sum2;
    sum2 = sum2 + prob1(i,1);
    if a >= sum1 && a < sum2
        father = i;
        break
    end
   
end



end
