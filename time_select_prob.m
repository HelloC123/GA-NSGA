function [ prob1 ] = time_select_prob( pop_size,fitness_time)
sum1 = 0;
% sum2 = 0;
for i = 1:pop_size
    sum1 = sum1 + fitness_time(i,1);
%     sum2 = sum2 + fitness_cost(i,1)
end

prob1 = zeros(pop_size,1);
% prob2 = zeros(pop_size,1)
for j = 1:pop_size
   prob1(j,1) = fitness_time(j,1)/sum1;
%    prob2(j,1) = fitness_cost(j,1)/sum2
end


end

