Initialize;
syms z;
% empty:
uf_empty=UsingAdhensionFront(beta,z,L,b_empty,hg_empty);
ur_empty=UsingAdhensionRear(beta,z,L,a_empty,hg_empty);
ef_empty=BrakingEffFront(b_empty,L,beta,uf_empty,hg_empty);
er_empty=BrakingEffRear(a_empty,L,beta,ur_empty,hg_empty);
%full:
uf_full=UsingAdhensionFront(beta,z,L,b_full,hg_full);
ur_full=UsingAdhensionRear(beta,z,L,a_full,hg_full);
ef_full=BrakingEffFront(b_full,L,beta,uf_full,hg_full);
er_full=BrakingEffRear(a_full,L,beta,ur_full,hg_full);
f=z;
ezplot(uf_empty);
axis([0 1.0 0 1.0]);
hold on;
ezplot(ur_empty);
ezplot(uf_full);
ezplot(ur_full);
axis([0 1.0 0 1.0]);
%% draw coff:
hold on;
gtext('uf_empty');
gtext('ur_empty');
gtext('uf_full');
gtext('ur_full');
ezplot(z,z);
axis([0 1.0 0 1.0]);
gtext('u=z');
title('利用附着系数曲线');
xlabel('制动强度 z/g');
ylabel('利用附着系数');
% 制动法规：
z=0.15:0.05:0.8;
u_ece=zeros(1,length(z));
u_ece_=[];
z_=[];
u_ece_index=1;
for i=1:length(z)
if (z(i)<0.3&&z(i)>=0.15)
    u_ece(i)=z(i)+0.08;
    u_ece_(u_ece_index)=z(i)-0.08;
    z_(u_ece_index)=z(i);
    u_ece_index=u_ece_index+1;
end
if(z(i)>=0.3)        
    u_ece(i)=0.38+(z(i)-0.3)/0.74;
end
end
plot(z,u_ece,'LineWidth',2,'Color','r');
plot(z_,u_ece_,'LineWidth',2,'Color','r');
%% draw eff:
figure;
title('前后制动效率曲线');
xlabel('附着系数u');
ylabel('制动效率');
hold on;
axis([0 1 0 100]);
%plot(uf_empty,ef_empty*100);
%gtext('Ef');
plot(ur_empty,er_empty*100);
gtext('Er');
plot(uf_full,ef_full*100);
gtext('Ef');
plot(ur_full,er_full*100);
gtext('Er');
gtext('满载');gtext('空载');