function [ father ] = father_pair_cost(pop_size)
father = [];
for i = 1 : pop_size/2
     diff_1 = 1;
     father1 = ceil(rand(1)*pop_size);
     while diff_1 == 1
         father2 = ceil(rand(1)* pop_size);
         if father1 ~= father2
             diff_1 = 0;   
         else
             diff_1 = 1;
         end
     end
     
      father = [father;father1,father2];  
end  
end
    





