clear
clc

pop_size =100 ;
n = 10;       %需求点个数
m = 3;       %DC 数
k = 4;         %车辆数
Pc = 0.9;     %交叉概率
Pm = 1-Pc;
G = 8;       %迭代次数
BI_NUM = 2;        %多目标运行次数
NO_S =10;           %情景数
RE = 50;             %单目标运行次数
% 各情景（No_s）各单目标cost, time 各运行 re 次 
% for No_s = 1:NO_S 
%     No_s;
%     for re = 1:RE         %重复次数
%         re;
%         cost(No_s,re)= flrp_cost(pop_size, n, m, k, Pc, Pm, G,No_s);
%         time(No_s,re)= time_flrp(pop_size, n, m, k, Pc, Pm, G,No_s);
%     end
%     min_cost(No_s)= min(cost(No_s,:))
%     min_time(No_s)= min(time(No_s,:))
%  end

% 单目标各情景最优值
min_time = [144 144 144 144 144 144 144 144 144 144 ];
min_cost = [14368	14251 14260 14449 14890 14449 15380 14881 14449 14962 ];

for a = 1 : BI_NUM
    a
    [Group,size_father,size_children,size_Group,iteration_solution] = bi_flrp(pop_size, n, m, k, Pc, Pm, G, min_cost, min_time);
%   iteration_solution  每次迭代的解
% pareto(((a-1)*pop_size+1):((a-1)*pop_size+pop_size),:) = Group(:,size(Group,2)-3:size(Group,2)-2);
    time_solution{a,:}=iteration_solution;   %每一次nsga解
   b(a,:) = size_father;
   c(a,:)= size_children;
   d(a,:)= size_Group;
end




% plot(Group(:,2*n+k+5*n+1),Group(:,2*n+k+5*n+2),'*');