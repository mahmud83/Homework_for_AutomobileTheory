
%��������ƽ��ͼ
Initialize;
n=n_min:100:n_max;
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
title('��������ƽ��ͼ');
ylabel('Pe / kW');
xlabel('ua / (km��h^-1)');

