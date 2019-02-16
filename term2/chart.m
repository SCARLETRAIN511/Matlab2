clear
clc
load('delrin.mat');
load('al.mat');
load('cf.mat');
E_delrin=table2array(G1Copy1(1:551,1));
F_delrin=table2array(G1Copy1(1:551,2));
E_cf=table2array(G1(1:202,1));
F_cf=table2array(G1(1:202,2));
E_al=table2array(G1CopyCopy(1:344,1));
F_al=table2array(G1CopyCopy(1:344,2));                   

strain_delrin=E_delrin./20;
stress_delrin=F_delrin./(12.19*1.02*0.000000001);
strain_cf=E_cf./80;
stress_cf=F_cf./(10.05*0.9*0.000000001);
strain_al=E_al./50;
stress_al=F_al./(6.19*2.51*0.000000001);

strainT_delrin=log(strain_delrin+1);
strainT_cf=log(strain_cf+1);
strainT_al=log(strain_al+1);

stressT_delrin=stress_delrin.*(1+strain_delrin);
stressT_cf=stress_cf.*(1+strain_cf);
stressT_al=stress_al.*(1+strain_al);

plot(strainT_delrin,stressT_delrin,'-r');
hold on
plot(strainT_cf,stressT_cf,'-b');
hold on 
plot(strainT_al,stressT_al,'-k');
hold off
