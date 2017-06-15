%等速百公里燃油消耗
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
%% 算出怠速时候的pg
n_lspeed=400;
temp_n=n_lspeed/1000;
T_q_lspeed=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;%怠速时候的转矩
P_e_lspeed=DrivePower(T_q_lspeed,n_lspeed);%怠速时候的功率
temp_u_a=DriveSpeed(n_lspeed,r,i_g(1),i_0);
b_lspeed=polyval(B1,temp_u_a);
%pg=P_e_lspeed*b_lspeed/(367.1*0.299);
pg=7.05;
%% 算第四档和第五档：
for i=4:length(i_g)
    B=0;
    if (i==4)
        B=B4;
    else
        B=B5;
    end
n_=600:100:4000;
u_a=DriveSpeed(n_,r,i_g(i),i_0);
temp_n=n_/1000;
T_q=-19.313+295.27*temp_n-165.44*temp_n.^2+40.874*temp_n.^3-3.8445*temp_n.^4;%怠速时候的转矩
P_res=ResPower(G,f,u_a,CdA,K);
b=polyval(B,u_a);
Q_s=FuelConsume(P_res,b,u_a,pg);
hold on;
plot(u_a,Q_s);
gtext(Romance(i));
end
title('汽车等速百公里燃油消耗量曲线');
ylabel('Qs / L/100km');
xlabel('ua / (km·h^-1)');

