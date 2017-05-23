%等速百公里燃油消耗
addpath('C:\Users\Chen\Desktop\汽车理论\Program\core_func\');
m=3880;
G=m*9.8;
f=0.013;
i_0=5.83;
r=0.367;
K=0.85;
CdA=2.77;
B_0=[1326.8,1354.7,1284.4,1122.9,1141.0,1051.2,1233.9,1129.7];
B_1=[-416.46 -303.98 -189.75 -121.59 -98.893 -73.714 -84.478 -45.291];
B_2=[72.379 36.657 14.524 7.0035 4.4763 2.8593 2.9788 0.71113];
B_3=[-5.8629 -2.0553 -0.51184 -0.18517 -0.091077 -0.05138 -0.047449 -0.00075215];
B_4=[0.17768 0.043072 0.0068164 0.0018555 0.00068906 0.00035032 0.00028230 -0.000038568];
n=[815,1207,1614,2012,2603,3006,3403,3804];
%怠速时候的pg：
n_lspeed=400;
temp_n=n_lspeed/1000;
T_q_lspeed=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;%怠速时候的转矩
P_e_lspeed=DrivePower(T_q_lspeed,n_lspeed);%怠速时候的功率
%我认为，拟合的应该是它的转速，要求出 n_lspeed 时候对应的参数：
[p0,p1,p2,p3,p4]=drawpoly(n,B_0,B_1,B_2,B_3,B_4);
B_0_=polyval(p0,n_lspeed,1);
B_1_=polyval(p1,n_lspeed,1);
B_2_=polyval(p2,n_lspeed,1);
B_3_=polyval(p3,n_lspeed,1);
B_4_=polyval(p4,n_lspeed,1);
b_lspeed=B_0_+B_1_.*P_e_lspeed+B_2_.*P_e_lspeed.^2+B_3_.*P_e_lspeed.^3+B_4_.*P_e_lspeed.^4;
pg=P_e_lspeed*b_lspeed/(367.1*0.299);

%最高挡&此高
i_g=[5.56,2.769,1.644,1.00,0.793];
for i=4:length(i_g)
n_=600:100:4000;
u_a=DriveSpeed(n_,r,i_g(i),i_0);
B_0_=polyval(p0,n_,1);
B_1_=polyval(p1,n_,1);
B_2_=polyval(p2,n_,1);
B_3_=polyval(p3,n_,1);
B_4_=polyval(p4,n_,1);
b=B_0_+B_1_.*P_e_lspeed+B_2_.*P_e_lspeed.^2+B_3_.*P_e_lspeed.^3+B_4_.*P_e_lspeed.^4;
temp_n=n_/1000;
T_q=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;%怠速时候的转矩
P_e=DrivePower(T_q,n_);
Q_s=FuelConsume(P_e,b,u_a,pg);
hold on;
plot(u_a,Q_s);
gtext(Romance(i));
end
title('汽车等速百公里燃油消耗量曲线');
ylabel('Qs / L/100km');
xlabel('ua / (km·h^-1)');

function [p0,p1,p2,p3,p4]=drawpoly(n,B_0,B_1,B_2,B_3,B_4)
% hold on;
% plot(n,B_0);
% gtext('B0');
% plot(n,B_1);
% gtext('B1');
% plot(n,B_2);
% gtext('B2');
% plot(n,B_3);
% gtext('B3');
% plot(n,B_4);
% gtext('B4');
p0=polyfit(n,B_0,2);
p1=polyfit(n,B_1,1);
p2=polyfit(n,B_2,1);
p3=polyfit(n,B_3,1);
p4=polyfit(n,B_4,1);
% B_0_=polyval(p0,n,1);
% B_1_=polyval(p1,n,1);
% B_2_=polyval(p2,n,1);
% B_3_=polyval(p3,n,1);
% B_4_=polyval(p4,n,1);
% plot(n,B_0_);
% gtext('B0拟合');
% plot(n,B_1_);
% gtext('B1拟合');
% plot(n,B_2_);
% gtext('B2拟合');
% plot(n,B_3_);
% gtext('B3拟合');
% plot(n,B_4_);
% gtext('B4拟合');
% title('各参数拟合曲线图');
% xlabel('n / r/min');
% ylabel('B参数数值');
%返回
% B_0_=polyval(p0,n_dst,1);
% B_1_=polyval(p1,n_dst,1);
% B_2_=polyval(p2,n_dst,1);
% B_3_=polyval(p3,n_dst,1);
% B_4_=polyval(p4,n_dst,1);
end
