%% 初始化
Initialize;
%% 拟合：
n=[815,1207,1614,2012,2603,3006,3403,3804];
temp_n=n/1000;
T_tq=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;
i_g=[5.56,2.769,1.644,1.00,0.793];
u_a=zeros(5,length(n));
P_e=DrivePower(T_tq,n);
for i=1:5
u_a(i,:)=DriveSpeed(n,r,i_g(i),i_0);
end
B_0=[1326.8,1354.7,1284.4,1122.9,1141.0,1051.2,1233.9,1129.7];
B_1=[-416.46 -303.98 -189.75 -121.59 -98.893 -73.714 -84.478 -45.291];
B_2=[72.379 36.657 14.524 7.0035 4.4763 2.8593 2.9788 0.71113];
B_3=[-5.8629 -2.0553 -0.51184 -0.18517 -0.091077 -0.05138 -0.047449 -0.00075215];
B_4=[0.17768 0.043072 0.0068164 0.0018555 0.00068906 0.00035032 0.00028230 -0.000038568];
b_have_exist=B_0+B_1.*P_e+B_2.*P_e.^2+B_3.*P_e.^3+B_4.*P_e.^4;
B1=polyfit(u_a(1,:),b_have_exist,3); %对于每一个挡位
B2=polyfit(u_a(2,:),b_have_exist,3);
B3=polyfit(u_a(3,:),b_have_exist,3);
B4=polyfit(u_a(4,:),b_have_exist,3);
B5=polyfit(u_a(5,:),b_have_exist,3);
B=[B1;B2;B3;B4;B5];
pg=7.05;
%% 求
i_0=[5.17,5.43,5.83,6.17,6.33];
accTime=zeros(1,length(i_0));
Q_ConsumeArray=zeros(1,length(i_0));
for i=1:length(i_0)
accTime(i)=GetAccTime(i_0(i));
end
for i_0_index=1:length(i_0)
u_each_max=zeros(0,length(i_g));
u_each_min=zeros(0,length(i_g));
for i=1:length(i_g)
u_a=DriveSpeed(n,r,i_g(i),i_0(i_0_index));
u_each_max(i)=max(u_a);
u_each_min(i)=min(u_a);
end
u_a=floor(u_each_min(1)):1:70;
time=zeros(1,length(u_a));
status=1; % u_a处于的区间
S=0; %积分面积区域
Q_Consume_mL=0;
for i=1:length(u_a)
    if(u_a(i)>u_each_max(status))
        status=status+1; 
    end
    temp_n=u_a(i)*i_g(status)*i_0(i_0_index)/(0.377*r);
    temp_n=temp_n/1000;
    T_tq=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;
    F_drive=DriveForce(T_tq,i_g(status),i_0(i_0_index),K,r);
    F_res=Resistance(G,f,CdA,u_a(i));
    trans=TransParameter(I_w_sum,m,r,I_f,i_0(i_0_index),i_g(status),K);
    acc=Acceleration(trans,m,F_drive,F_res);
    S=S+1./acc;
    time(i)=S;
    %当前速度 u_a(i)
    B_=B(status,:);
    b=polyval(B_,u_a(i));
     %计算加速工况燃油消耗率，在每一个小区间里面算
    P_e=(G*f*u_a(i)/3600+CdA*u_a(i).^3/76140+trans*m*u_a(i)*acc/3600)/K;
    Q_t=P_e*b/(367.1*pg);
    t_delta=1/(3.6*acc);
    Q_Consume_mL=Q_Consume_mL+Q_t*t_delta;
end
Q_ConsumeArray(i_0_index)=Q_Consume_mL./accTime(i_0_index);
end
plot(Q_ConsumeArray,accTime);
gtext('i_0=5.17');
gtext('i_0=5.43');
gtext('i_0=5.83');
gtext('i_0=6.17');
gtext('i_0=6.33');
title('燃油经济性-加速时间曲线');
ylabel('加速时间到70km/h的消耗时间 / s');
xlabel('燃油经济性Qt mL/s');

function acctime=GetAccTime(i_0_new)
global m G f i_0 r K CdA I_f I_w_sum n_min n_max;
i_0=i_0_new;
n=n_min:100:n_max;
i_g=[5.56,2.769,1.644,1.00,0.793];
length_=length(i_g);
u_each_max=zeros(0,length_);
u_each_min=zeros(0,length_);
for i=1:length_
u_a=DriveSpeed(n,r,i_g(i),i_0);
u_each_max(i)=max(u_a);
u_each_min(i)=min(u_a);
end
u_a=floor(u_each_min(1)):1:floor(u_each_max(length_));
time=zeros(1,length(u_a));
status=1;
S=0; 
for i=1:length(u_a)
    if(u_a(i)>u_each_max(status))
        status=status+1; 
    end
    temp_n=u_a(i)*i_g(status)*i_0/(0.377*r);
    temp_n=temp_n/1000;
    T_tq=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;
    F_drive=DriveForce(T_tq,i_g(status),i_0,K,r);
    F_res=Resistance(G,f,CdA,u_a(i));
    trans=TransParameter(I_w_sum,m,r,I_f,i_0,i_g(status),K);
    acc=Acceleration(trans,m,F_drive,F_res);
    S=S+1./acc;
    time(i)=S;
end
time=time/3.6;
index_=find(u_a==70);
acctime=time(index_);
end


