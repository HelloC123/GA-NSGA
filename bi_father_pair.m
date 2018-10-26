function [ father ] = father_pair(pop_size,prob1)
father = [];
for i = 1:pop_size/2
   diff = 1 ;
   father1 = select_father(pop_size,prob1);
   while diff == 1
       father2 = select_father(pop_size,prob1);
       if father2 == father1
           diff = 1;
       else
           diff = 0;
       end     
   end
   father = [father;father1,father2];
end
    
end
    





