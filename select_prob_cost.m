function [ prob1 ] = select_prob_cost( pop_size,fitness_cost)
sum1 = 0;

for i = 1:pop_size
    sum1 = sum1 + fitness_cost(i,1);
end

prob1 = zeros(pop_size,1);
for j = 1:pop_size
   prob1(j,1) = fitness_cost(j,1)/sum1;
end


end

