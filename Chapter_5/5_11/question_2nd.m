Initialize;
u=0:0.05:25;
K=StabilityCoefficient(m,L,a,k2,b,k1);
ss=SteeringSensitivity(u,L,K);
plot(u,ss);

title('��������̬��ڽ��ٶ���������');
xlabel('ua /(m/s)');
ylabel('��̬��ڽ�����');
index=find(u==22.35);
hold on;
x=[22.35,22.35];
y=[ss(index),0];
plot(x,y,'-.','markersize',14,'LineWidth',2);
x=[22.35,0];
y=[ss(index),ss(index)];
plot(x,y,'--','markersize',14,'LineWidth',2);
axis([0 25 0 3.5]);
