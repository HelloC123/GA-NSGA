function [ Group ] = bi_pop( pop_size,n,k,m )

for i = 1:pop_size
    Group(i,1:n) = ceil(k*rand(1,n));
    Group(i,n+1:2*n) = randperm(n);
    Group(i,2*n+1:2*n+k) = ceil(m*rand(1,k));
    for j = 1:5*n
       if rand < 0.5
           Group(i,2*n+k+j) = 0;
       else
           Group(i,2*n+k+j) = 1;
       end
    end
end

end

