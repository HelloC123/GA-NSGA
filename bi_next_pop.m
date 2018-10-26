function [ Group] = bi_next_pop(Group1, Group2,pop_size,n,k )

family = zeros(size(Group1,1)+size(Group2,1),size(Group1,2));
for i = 1:size(Group1,1)
   family(i,:) = Group1(i,:) ;
end
for j = 1:size(Group2,1)
   family(size(Group1,1)+j,1:2*n+k+5*n+2+2) = Group2(j,:) ;
end
family1 = bi_non_dorminated_sort(family,  n, k );


% Get the index for the population sort based on the rank
[~,index] = sort(family1(:,size(family1,2)-1));


% Now sort the individuals based on the index
for i = 1 : size(family1,1)
    sorted_family1(i,:) = family1(index(i),:);
end

% Find the maximum rank in the current population
max_rank = max(family1(:,size(family1,2)-1));

% Start adding each front based on rank and crowing distance until the
% whole population is filled.
previous_index = 0;
for i = 1 : max_rank
    % Get the index for current rank i.e the last the last element in the
    % sorted_chromosome with rank i. 
    current_index = max(find(sorted_family1(:,size(family1,2)-1) == i));
    % Check to see if the population is filled if all the individuals with
    % rank i is added to the population. 
    if current_index > pop_size
        % If so then find the number of individuals with in with current
        % rank i.
        remaining = pop_size - previous_index;
        % Get information about the individuals in the current rank i.
        temp_pop = ...
            sorted_family1(previous_index + 1 : current_index, :);
        % Sort the individuals with rank i in the descending order based on
        % the crowding distance.
        [~,temp_sort_index] = sort(temp_pop(:, size(family1,2)),'descend');
        % Start filling individuals into the population in descending order
        % until the population is filled.
        for j = 1 : remaining
            Group(previous_index + j,:) = temp_pop(temp_sort_index(j),:);
        end
        return;
    elseif current_index < pop_size
        % Add all the individuals with rank i into the population.
        Group(previous_index + 1 : current_index, :) = ...
            sorted_family1(previous_index + 1 : current_index, :);
    else
        % Add all the individuals with rank i into the population.
        Group(previous_index + 1 : current_index, :) = ...
            sorted_family1(previous_index + 1 : current_index, :);
        return;
    end
    % Get the index for the last added individual.
    previous_index = current_index;
end

end

