%驱动力和行驶阻力平衡图
%选择第五档
addpath('C:\Users\Chen\Desktop\汽车理论\Program\core_func\');
n=600:100:4000;
i_0=5.83;
r=0.367;
K=0.85;
m=3880;
G=m*9.8;
f=0.013;
CdA=2.77;
temp_n=n/1000;
T_tq=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;

i_g=[5.56,2.769,1.644,1.00,0.793];

for i=1:length(i_g)
u_a=DriveSpeed(n,r,i_g(i),i_0);
F_drive=DriveForce(T_tq,i_g(i),i_0,K,r);
F_res=Resistance(G,f,CdA,u_a);
hold on;
plot(u_a,F_drive);
gtext(['Ft' num2str(i)]);
plot(u_a,F_res,'r');
end
gtext('Ff+Fw');
title('第五档汽车驱动力和行驶阻力平衡图');
ylabel('Ft / kN ');
xlabel('ua / (km·h^-1)');