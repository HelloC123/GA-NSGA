clear
clc

pop_size =100 ;
n = 10;       %��������
m = 3;       %DC ��
k = 4;         %������
Pc = 0.9;     %�������
Pm = 1-Pc;
G = 8;       %��������
BI_NUM = 2;        %��Ŀ�����д���
NO_S =10;           %�龰��
RE = 50;             %��Ŀ�����д���
% ���龰��No_s������Ŀ��cost, time ������ re �� 
% for No_s = 1:NO_S 
%     No_s;
%     for re = 1:RE         %�ظ�����
%         re;
%         cost(No_s,re)= flrp_cost(pop_size, n, m, k, Pc, Pm, G,No_s);
%         time(No_s,re)= time_flrp(pop_size, n, m, k, Pc, Pm, G,No_s);
%     end
%     min_cost(No_s)= min(cost(No_s,:))
%     min_time(No_s)= min(time(No_s,:))
%  end

% ��Ŀ����龰����ֵ
min_time = [144 144 144 144 144 144 144 144 144 144 ];
min_cost = [14368	14251 14260 14449 14890 14449 15380 14881 14449 14962 ];

for a = 1 : BI_NUM
    a
    [Group,size_father,size_children,size_Group,iteration_solution] = bi_flrp(pop_size, n, m, k, Pc, Pm, G, min_cost, min_time);
%   iteration_solution  ÿ�ε����Ľ�
% pareto(((a-1)*pop_size+1):((a-1)*pop_size+pop_size),:) = Group(:,size(Group,2)-3:size(Group,2)-2);
    time_solution{a,:}=iteration_solution;   %ÿһ��nsga��
   b(a,:) = size_father;
   c(a,:)= size_children;
   d(a,:)= size_Group;
end




% plot(Group(:,2*n+k+5*n+1),Group(:,2*n+k+5*n+2),'*');