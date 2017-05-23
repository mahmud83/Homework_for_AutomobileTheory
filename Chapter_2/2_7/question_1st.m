%汽车功率平衡图
addpath('C:\Users\Chen\Desktop\汽车理论\Program\core_func\');

m=3880;
G=m*9.8;
f=0.013;
i_0=5.83;
r=0.367;
K=0.85;
CdA=2.77;
n=600:100:4000;
temp_n=n/1000;
T_q=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;
i_g=[5.56,2.769,1.644,1.00,0.793];
for i=1:length(i_g)
u_a=DriveSpeed(n,r,i_g(i),i_0);
P_e=DrivePower(T_q,n);
P_res=ResPower(G,f,u_a,CdA,K);
hold on;
plot(u_a,P_e);
gtext(Romance(i));
plot(u_a,P_res,'r');
axis([0 120 0 100]);
end
gtext('Pf+Pw/K');
title('汽车功率平衡图');
ylabel('Pe / kW');
xlabel('ua / (km·h^-1)');

