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
status=1; % u_a处于的区间
S=0; %积分面积区域
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