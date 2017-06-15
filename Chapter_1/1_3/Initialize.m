% 初始化，面向1.3题
clc;
clear;
addpath('C:\Users\Chen\Desktop\汽车理论\Program\core_func\');
global m G f i_0 r K CdA I_f I_w_sum n_min n_max;
m=3880;
G=m*9.8;
f=0.013;
i_0=5.83; % change when 3.1
r=0.367;
K=0.85;
CdA=2.77;
I_f=0.218;
I_w_sum=1.798+3.598;
n_min=600;
n_max=4000;