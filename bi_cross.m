function [f] = bi_cross(father,n,k,m,Pc,min_cost, min_time)

% p = 1;
% Flags used to set if crossover and mutation were actually performed. 
was_crossover = 0;
% no_crossover = 0;
was_mutation = 0;
for i = 1 : size(father,1)
    % With 90 % probability perform crossover
    rand_num(1,i) = rand(1);
    if rand_num(i) < Pc
        % Initialize the children to be null vector.
        child_1 = [];
        child_2 = [];
        % Select the first parent
        parent_1 = round(size(father,1)*rand(1));
        if parent_1 < 1
            parent_1 = 1;
        end
        % Select the second parent
        parent_2 = round(size(father,1)*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end
        % Make sure both the parents are not the same. 
        while isequal(father(parent_1,:),father(parent_2,:))
            parent_2 = round(size(father,1)*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
        end
        % Get the chromosome information for each randomnly selected
        % parents
        parent_1 = father(parent_1,:);
        parent_2 = father(parent_2,:);
        % Perform corssover for each decision variable in the chromosome.
         %第一段 两点交叉
        point1 = floor(rand(1) * (n-2)) + 2;
        diff_1 = 1;
        temp_1 = 0;
        while diff_1 == 1
            point2 = floor(rand(1) *(n-2)) + 2;
            if point1 ~= point2
                diff_1 = 0;
                if point1 > point2
                    temp_1 = point1;
                    point1 = point2;
                    point2 = temp_1;
                end             
            end
        end
        child_1(1,1:point1) = parent_1(1,1:point1);      
        child_1(1,point1:point2) = parent_2(1,point1:point2);
        child_1(1,point2:n) = parent_1(1,point2:n);
        child_2(1,1:point1) = parent_2(1,1:point1);
        child_2(1,point1:point2) = parent_1(1,point1:point2);
        child_2(1,point2:n) =  parent_2(1,point2:n);
        
        
         %第三段 两点交叉
        point5 = floor(rand(1) * (k-2)) + 2;
        diff_3 = 1;
        temp_3 = 0;
        while diff_3 == 1
            point6 = floor(rand(1) * (k-2)) + 2;
            if point5 ~= point6
                diff_3 = 0;
                if point5 > point6
                    temp_3 = point5;
                    point5 = point6;
                    point6 = temp_3;
                end             
            end
        end
        child_1(1,2*n+1:2*n+point5) = parent_1(1,2*n+1:2*n+point5);
        child_1(1,2*n+point5:2*n+point6) = parent_2(1,2*n+point5:2*n+point6);
        child_1(1,2*n+point6:2*n+k) = parent_1(1,2*n+point6:2*n+k);
        child_2(1,2*n+1:2*n+point5) = parent_2(1,2*n+1:2*n+point5);
        child_2(1,2*n+point5:2*n+point6) = parent_1(1,2*n+point5:2*n+point6);
        child_2(1,2*n+point6:2*n+k) = parent_2(1,2*n+point6:2*n+k);
        
        
        
         %第四段 两点交叉
        point7 = floor(rand(1) * (5*n-2)) + 2;
        diff_4 = 1;
        temp_4 = 0;
        while diff_4 == 1
            point8 = floor(rand(1) *(5*n-2)) + 2;
            if point7 ~= point8
                diff_4 = 0;
                if point7 > point8
                    temp_4 = point7;
                    point7 = point8;
                    point8 = temp_4;
                end             
            end
        end
        child_1(1,2*n+k+1:2*n+k+point7) = parent_1(1,2*n+k+1:2*n+k+point7);
        child_1(1,2*n+k+point7:2*n+k+point8) = parent_2(1,2*n+k+point7:2*n+k+point8);
        child_1(1,2*n+k+point8:2*n+k+5*n) = parent_1(1,2*n+k+point8:2*n+k+5*n);
        child_2(1,2*n+k+1:2*n+k+point7) = parent_2(1,2*n+k+1:2*n+k+point7);
        child_2(1,2*n+k+point7:2*n+k+point8) = parent_1(1,2*n+k+point7:2*n+k+point8);
        child_2(1,2*n+k+point8:2*n+k+5*n) = parent_2(1,2*n+k+point8:2*n+k+5*n);
        
        
%         %第二段 部分匹配交叉
        a0 = parent_1(1,n+1:2*n);
        b0 = parent_2(1,n+1:2*n);
        child_1(1,n+1:2*n) = parent_1(1,n+1:2*n);
        child_2(1,n+1:2*n) = parent_2(1,n+1:2*n); 
      
        point3 = floor(rand(1) * n ) + 1;
        diff_2 = 1;
        temp_2 = 0;
        while diff_2 == 1
            point4 = floor(rand(1) * n) + 1;
            if point3 ~= point4
                diff_2 = 0;
                if point3 > point4
                    temp_2 = point3;
                    point3 = point4;
                    point4 = temp_2;
                end             
            end
        end
        for j =point3 : point4
           a1 = child_1(1,n+1:2*n);
           b1 = child_2(1,n+1:2*n);
           child_1(1,n+j) = b0(j);
           child_2(1,n+j) = a0(j);
           x = find(child_1(1,n+1:2*n) == child_1(1,n+j));
           y = find(child_2(1,n+1:2*n) == child_2(1,n+j));
           j1 = x( x ~= j);
           j2 = y( y~= j);
           if ~isempty(j1)
              child_1(1,n+j1) = a1(j);
           end
           if ~isempty(j2)
              child_2(1,n+j2) = b1(j);
           end
        end
        % Evaluate the objective function for the offsprings and as before
        % concatenate the offspring chromosome with objective value.
        [child_1,~,~] = bi_decode( child_1,n,k,m,min_cost, min_time );
        [child_2,~,~] = bi_decode( child_2,n,k,m ,min_cost, min_time);
        % Set the crossover flag. When crossover is performed two children
        % are generate, while when mutation is performed only only child is
        % generated.
        was_crossover = 1;
        was_mutation = 0;
    % With 10 % probability perform mutation. Mutation is based on
    % polynomial mutation. 
    else
        % Select at random the parent.
        parent_3 = round(size(father,1)*rand(1));
        if parent_3 < 1
            parent_3 = 1;
        end
         parent_4 = round(size(father,1)*rand(1));
        if parent_4 < 1
            parent_4 = 1;
        end
        % Make sure both the parents are not the same. 
        while isequal(father(parent_3,:),father(parent_4,:))
            parent_4 = round(size(father,1)*rand(1));
            if parent_4 < 1
                parent_4 = 1;
            end
        end
        % Get the chromosome information for the randomnly selected parent.
%          parent_3 = father(parent_3,:);
%          child_3 = parent_3;
        parent_3 = father(parent_3,1:size(father,2)-2);
        parent_4 = father(parent_4,1:size(father,2)-2);
        child_3 = parent_3;
        child_4 = parent_4;
        % Perform mutation on eact element of the selected parent.
        %第一段 对换变异
      point1 = floor(rand(1) * n) + 1;
      diff_1 = 1;
      temp_1 = 0;
      while diff_1 == 1
          point2 = floor(rand(1) * n) + 1;
          if point1 ~= point2
              diff_1 = 0;
              if point1 > point2
                  temp_1 = point1;
                  point1 = point2;
                  point2 = temp_1;
              end             
          end
      end
      b = parent_3(1,point1);
      child_3(1,point1) = parent_3(1,point2);
      child_3(1,point2) = b;
      
      bb = parent_4(1,point1);
      child_4(1,point1) = parent_4(1,point2);
      child_4(1,point2) = bb;
      
      
      
      %第二段  逆转变异
      point3 = floor(rand(1) * n ) + 1;
      diff_2 = 1;
      temp_2 = 0;
      while diff_2 == 1
          point4 = floor(rand(1) * n) + 1;
          if point3 ~= point4
              diff_2 = 0;
              if point3 > point4
                  temp_2 = point3;
                  point3 = point4;
                  point4 = temp_2;
              end             
          end
      end

      for c = point3:point4
        child_3(1,n+c) = parent_3(1,n+point3+point4-c) ;
        child_4(1,n+c) = parent_4(1,n+point3+point4-c) ;
      end
      
      
      %第三段 对换变异
      point5 = floor(rand(1) * k) + 1;
      diff_3 = 1;
      temp_3 = 0;
      while diff_3 == 1
          point6 = floor(rand(1) * k) + 1;
          if point5 ~= point6
              diff_3 = 0;
              if point5 > point6
                  temp_3 = point5;
                  point5 = point6;
                  point6 = temp_3;
              end             
          end
      end
      for e = point5:point6
          pp = parent_3(1,2*n+e)-1;
          ppp = parent_4(1,2*n+e)-1;
          if pp < 1
              pp = 3;
          end
           if ppp < 1
              ppp = 3;
          end
        child_3(1,2*n+e) = pp ;
        child_4(1,2*n+e) = ppp ;
      end
      
      
      %第四段 逆转变异
      point7 = floor(rand(1) * (5*n)) + 1;
      diff_4 = 1;
      temp_4 = 0;
      while diff_4 == 1
          point8 = floor(rand(1) *(5*n-2)) + 2;
          if point7 ~= point8
              diff_4 = 0;
              if point7 > point8
                  temp_4 = point7;
                  point7 = point8;
                  point8 = temp_4;
              end             
          end
      end

      for d = point7:point8
        child_3(1,2*n+k+d) = parent_3(1,2*n+k+point7+point8-d) ;
        child_4(1,2*n+k+d) = parent_4(1,2*n+k+point7+point8-d) ;
      end
        % Evaluate the objective function for the offspring and as before
        % concatenate the offspring chromosome with objective value.    
       [child_3,~,~] = bi_decode( child_3,n,k,m,min_cost, min_time );
       [child_4,~,~] = bi_decode( child_4,n,k,m,min_cost, min_time );
        % Set the mutation flag
%         no_crossover = 1;
%         was_crossover = 0;
        was_mutation = 1;
        was_crossover = 0;

    end
    % Keep proper count and appropriately fill the child variable with all
    % the generated children for the particular generation.
    if was_crossover
        children(i,:) = child_1(1,:);
        children(i+size(father,1),:) = child_2(1,:);
        was_cossover = 0;
%         p = p + 2;
    elseif was_mutation
        children(i,:) = child_3(1,:);
        children(i+size(father,1),:) = child_4(1,:);
        was_mutation = 0;
%         p = p + 2;
    end
end

f = children;
end

