function [ children1 ] = bi_mutation( pop_size, Pm, Group, n, k,m)
 children1 = Group;
for i = 1:pop_size
  a = rand(1);
  if a <= Pm
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
      b = Group(i,point1);
      children1(i,point1) = Group(i,point2);
      children1(i,point2) = b;
      
      
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
        children1(i,n+c) = Group(i,n+point3+point4-c) ;
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
          p = Group(i,2*n+e)-1;
          if p < 1
              p = 3;
          end
        children1(i,2*n+e) = p ;
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
        children1(i,2*n+k+d) = Group(i,2*n+k+point7+point8-d) ;
      end
  end    
end


%!!!
[children1,~,~] = decode( children1,n,k,m );

% warn2 = cell(pop_size,1);
% error2 = 0;
% for p = 1:pop_size
%    warn2{p,1}= setdiff(children1(p,n+1:2*n),randperm(n)) ;
%    if size(warn2{p,1},2) > 0
%        error2 = error2 + 1;
%    end
%     
% end

end

