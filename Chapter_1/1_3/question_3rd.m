%行驶加速度倒数曲线
Initialize;
n=n_min:100:n_max;
temp_n=n/1000;
T_tq=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;

I_f=0.218;
I_w_sum=1.798+3.598;
i_g=[5.56,2.769,1.644,1.00,0.793];

for i=1:length(i_g)
u_a=DriveSpeed(n,r,i_g(i),i_0);
F_drive=DriveForce(T_tq,i_g(i),i_0,K,r);
F_res=Resistance(G,f,CdA,u_a);
trans=TransParameter(I_w_sum,m,r,I_f,i_0,i_g(i),K);
acc=Acceleration(trans,m,F_drive,F_res);
hold on;
plot(u_a,1./acc);
gtext(['1/a' num2str(i)]);
axis([0 100 0 10]);
end
title('汽车的行驶加速度倒数曲线');
ylabel('1/a / (m·s^-2)');
xlabel('ua / (km·h^-1)');