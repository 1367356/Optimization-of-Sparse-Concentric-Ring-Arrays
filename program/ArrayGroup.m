function [Array,element_sum,Circle_element_num,parameter]=ArrayGroup(Population_Init,circle_num,group_i,element_space,element_num,genetic_i,group_num)
%parameter  拟合函数的参数
%element_num  整个阵列的阵元个数
Perimeter=zeros(circle_num+1,1);
Circle_element_num=zeros(circle_num+1,1);  %每个圆环上有多少个阵元
Element_alpha=zeros(circle_num+1,1);

for circle_i=2:circle_num+1
    Perimeter(circle_i)=Population_Init(circle_i,group_i)*2*pi;    %各个圆环的半径存储起来。
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%每个圆环上的阵元数和保留比率    
Circle_element_num(1,1)=1;
Circle_element_num(2)=fix((Population_Init(2,group_i)*2*pi)/element_space);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%a =     -0.1927+rand()*0.0897  ;%(-0.1927, -0.103)
%b =     0.002972+0.002615*rand()  ;%(0.002972, 0.005587)
%c =      0.4679+rand()*0.1625  ;%(0.4679, 0.6304)
%        a =     -0.1928  ;%(-0.2816, -0.104)
%        b =    0.001384  ;%(-0.002002, 0.004771)
%        c =      0.6667  ;%(0.4894, 0.8439)
%        a =      0.7543 ;% (0.4253, 1.083)
%        b =      0.1981 ;% (-0.2391, 0.6353)
%        c =      0.1444  ;%(-0.1747, 0.4634)
%每个种群所对应的概率参数
% a =     -0.2927+rand()*0.2897  ;%(-0.1927, -0.103)
% b =     0.000972+0.007615*rand()  ;%(0.002972, 0.005587)
% c =      0.2679+rand()*0.5625  ;%(0.4679, 0.6304)
% a=-0.1857 ;
% b=0.0037;
% c=0.6225;

%        a =     -0.1479;
%        b =     0.00428 ;                              
%        c =      0.5492 ;

%        a =     -0.1289;%  (-0.1655, -0.09235)
%        b =    0.004673 ;% (0.003597, 0.005748)
%        c =      0.5193  ;%(0.4527, 0.5859)
%        a =     -0.2043;%  (-0.3814, -0.0272)
%        b =    0.002089  ;%(-0.004557, 0.008734)
%        c =      0.6646  ;%(0.3142, 1.015)
       
        a =     -0.1538 ;% (-0.2078, -0.09973)
       b =    0.004088  ;%(0.002347, 0.005828)
       c =      0.5607  ;%(0.4597, 0.6618)
%        a =     -0.1414 ;% (-0.2439, -0.03884)
%        b =    0.004213;  %(0.001221, 0.007205)
%        c =      0.5523 ; %(0.3663, 0.7384)
%%%%%%%%%%%%%%%%%%%%%%%%%
%阵元个数为132，张帅论文结果
  %     a =    -0.06559 ;% (-0.1609, 0.02969)
   %    b =    0.005705  ;%(0.002857, 0.008554)
    %   c =      0.4069  ;%(0.2321, 0.5818)
 %   a =    -0.1609+0.19059*rand() ;% (-0.1609, 0.02969)
  %  b =    0.002857+rand()*0.005697  ;%(0.002857, 0.008554)
  % c =      0.2321+rand()*0.3497  ;%(0.2321, 0.5818)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=3:circle_num
    p=save_rate_of_radius(Population_Init(k,group_i),a,b,c);
     Circle_element_num(k)=fix((Population_Init(k,group_i)*2*pi)/element_space*p);
end

%%%%%%%%%%%%%%%%%%%%%%%%Circle_element_num(circle_num+1)=element_num-sum(Circle_element_num(1:circle_num));
if element_num==0
     p=save_rate_of_radius(Population_Init(circle_num+1,group_i),a,b,c);
     Circle_element_num(circle_num+1)=fix((Population_Init(circle_num+1,group_i)*2*pi)/element_space*p);
else
    if element_num-sum(Circle_element_num(1:circle_num))<=0
        Circle_element_num(circle_num+1)=0;
    else
        Circle_element_num(circle_num+1)=element_num-sum(Circle_element_num(1:circle_num));
    end
end
parameter=[a,b,c];
for circle_i=2:circle_num+1
    Element_alpha(circle_i)=2*pi/Circle_element_num(circle_i); %每个圆环上，两个阵元间的角度。
end
element_sum=sum(Circle_element_num);
% Array=zeros(element_sum,1);
Array_1=zeros(element_sum,1);%半径阵列
Array_2=zeros(element_sum,1);%角度阵列
%----生成圆环满阵

for i=1:circle_num+1
 for k=1:Circle_element_num(i) 
     sum2=sum(Circle_element_num(1:i-1));
     locat=sum2+k;
     Array_1(locat)=Population_Init(i,group_i);%半径
     Array_2(locat)=(k-1)*Element_alpha(i);%角度
 end
end
Array=Array_1+Array_2*j;
   
