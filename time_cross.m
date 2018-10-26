function [ children ] = cross(father, Group, Pc,Pm, n, k)
children = zeros(size(Group,1),size(Group,2));
for i = 1:size(father,1)
    children(i,:) = Group(father(i,1),:);
    children(i+size(father,1),:) = Group(father(i,2),:);
    a = rand(1);
    if a < Pc
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
        children(i,1:point1) = Group(father(i,1),1:point1);
        children(i,point1:point2) = Group(father(i,2),point1:point2);
        children(i,point2:n) = Group(father(i,1),point2:n);
        children(i + size(father,1),1:point1) = Group(father(i,2),1:point1);
        children(i + size(father,1),point1:point2) = Group(father(i,1),point1:point2);
        children(i + size(father,1),point2:n) = Group(father(i,2),point2:n);
        
        
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
        children(i,2*n+1:2*n+point5) = Group(father(i,1),2*n+1:2*n+point5);
        children(i,2*n+point5:2*n+point6) = Group(father(i,2),2*n+point5:2*n+point6);
        children(i,2*n+point6:2*n+k) = Group(father(i,1),2*n+point6:2*n+k);
        children(i + size(father,1),2*n+1:2*n+point5) = Group(father(i,2),2*n+1:2*n+point5);
        children(i + size(father,1),2*n+point5:2*n+point6) = Group(father(i,1),2*n+point5:2*n+point6);
        children(i + size(father,1),2*n+point6:2*n+k) = Group(father(i,2),2*n+point6:2*n+k);
        
        
        
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
        children(i,2*n+k+1:2*n+k+point7) = Group(father(i,1),2*n+k+1:2*n+k+point7);
        children(i,2*n+k+point7:2*n+k+point8) = Group(father(i,2),2*n+k+point7:2*n+k+point8);
        children(i,2*n+k+point8:2*n+k+5*n) = Group(father(i,1),2*n+k+point8:2*n+k+5*n);
        children(i + size(father,1),2*n+k+1:2*n+k+point7) = Group(father(i,2),2*n+k+1:2*n+k+point7);
        children(i + size(father,1),2*n+k+point7:2*n+k+point8) = Group(father(i,1),2*n+k+point7:2*n+k+point8);
        children(i + size(father,1),2*n+k+point8:2*n+k+5*n) = Group(father(i,2),2*n+k+point8:2*n+k+5*n);
        
        
%         %第二段 部分匹配交叉
        a0 = Group(father(i,1),n+1:2*n);
        b0 = Group(father(i,2),n+1:2*n);
        children(i,n+1:2*n) =  Group(father(i,1),n+1:2*n);
        children(i+size(father,1),n+1:2*n) = Group(father(i,2),n+1:2*n); 
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
           a1 = children(i,n+1:2*n);
           b1 = children(i+size(father,1),n+1:2*n);
           children(i,n+j) = b0(j);
           children(i+size(father,1),n+j) = a0(j);
           x = find(children(i,n+1:2*n) == children(i,n+j));
           y = find(children(i+size(father,1),n+1:2*n) == children(i+size(father,1),n+j));
           j1 = x( x ~= j);
           j2 = y( y~= j);
           if ~isempty(j1)
              children(i,n+j1) = a1(j);
           end
           if ~isempty(j2)
              children(i+size(father,1),n+j2) = b1(j);
           end
        end
%     elseif a > 1 - Pm
%        % 保留
%        children(i,:) = Group(father(i,1),:);
%        children(i+size(father,1),:) = Group(father(i,2),:);
    else
% 变异
%       第一段 对换变异
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
      b = Group(father(i,1),point1);
      children(i,point1) = Group(father(i,1),point2);
      children(i,point2) = b;
      
      b1 = Group(father(i,2),point1);
      children(i+size(father,1),point1) = Group(father(i,2),point2);
      children(i+size(father,1),point2) = b1;
      
      
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
        children(i,n+c) = Group(father(i,1),n+point3+point4-c) ;
        children(i+size(father,1),n+c)= Group(father(i,2),n+point3+point4-c); 
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
          p = Group(father(i,1),2*n+e)-1;
          p1= Group(father(i,2),2*n+e)-1;
          if p < 1
              p = 3;
          end
          if p1 < 1
              p1 = 3;
          end
        children(i,2*n+e) = p ;
        children(i+size(father,1),2*n+e)=p1;
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
        children(i,2*n+k+d) = Group(father(i,1),2*n+k+point7+point8-d) ;
        children(i+size(father,1),2*n+k+d)=  Group(father(i,2),2*n+k+point7+point8-d) ;
      end
  end    
end

end


















