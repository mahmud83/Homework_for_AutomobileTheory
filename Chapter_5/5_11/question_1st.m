Initialize;
K=StabilityCoefficient(m,L,a,k2,b,k1);
u_ch=ChCrSpeed(K);

disp('稳定性系数K=');disp(K);
disp('特征车速uch=');disp(u_ch);
