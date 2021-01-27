%cfd coursework2
%author:Jiaxuan Tang 22/01/2021

clc
clear
close all;

gamma = 1.4;
xBegin = -2;
xEnd = 2;
%set the space
N = 100;

%initial condition
denRatio = 8;
preRatio = 10;
%set the deltaX and deltaT
deltaX = 4/N;
dX = [-2:deltaX:2];
deltaT = 0.05;
dT = [0:deltaT:0.5];

%initial conditions
rho = ones(1,length(dX));
rho(:,1:round(length(rho)/2)) = denRatio;
pressure = ones(1,length(dX));
pressure(:,1:round(length(pressure)/2)) = preRatio;
u = zeros(1,length(dX));
E=pressure./((gamma-1).*rho)+u.^2/2;
BigU = [rho;rho.*u;rho.*E];

%iteration until t = 0.5;
for n = 1:length(dT)
    for i = 1:length(dX)
        %initial value of u is 0;
        %for each dx
        mA = getMatrixA(u(i),E(i));
        eigValues(:,i) = sort(eig(mA)); 
        uvalue = eigValues(2,i);
        cvalue = eigValues(3,i) - eigValues(2,i);
        
        %from eig to get F+ F-
        %get F+;
        %get F-;    
        if (eigValues(1,i)>=0)
            FPlus(:,i)= [rho(i)*u(i);rho(i)*u(i)^2+pressure(i);rho(i)*u(i)*(E(i)+pressure(i)/rho(i))];
            FMinus(:,i)= [0;0;0];
        else
            FPlus(:,i) =rho(i)/(2*gamma)*[(2*gamma-1)*uvalue+cvalue;2*(gamma-1)*uvalue^2+(uvalue + cvalue)^2;(gamma-1)*uvalue^3+(uvalue-cvalue)^3/2+(3-gamma)/(2*(gamma-1))*(uvalue+cvalue)*cvalue^2];
            FMinus(:,i)= rho(i)*(uvalue-cvalue)/(2*gamma)*[1;uvalue-cvalue;(uvalue-cvalue)^2/2+(3-gamma)/(gamma-1)*cvalue^2/2];
        end
    end
    
   %get the new Bigu
    for i2 = 2:length(dX)-1 
        %BigU n+1 = BigU n + fun(F+,F-);
        BigU(:,i2) = BigU(:,i2) - deltaT/deltaX.*(FPlus(:,i2)-FPlus(:,i2-1)+(FMinus(i2+1)-FMinus(i2)));
        %update the big U
    end
    
    %get from U2 to Un-1, U2 = U1,Un = Un-1
    %get boundary conditions
    BigU(:,1) = BigU(:,2);
    BigU(:,length(dX)) = BigU(:,length(dX)-1); 
    %from BigU n +1,get new rho,v,pressure
    
    for i3 = 1:length(dX)
        rho(i3) = BigU(1,i3);
        u(i3) = BigU(2,i3)/BigU(1,i3);
        E(i3) = BigU(3,i3)/BigU(1,i3);
        pressure(i3) = (gamma-1)*rho(i3)*(E(i3)-u(i3)^2/2);
    end

end

plot(dX,u);

%functions
%matrix function handler for matrixA
function matrixA = getMatrixA(u,E)
    matrixA = [0,1,0;
        -1.6*u^2/2,1.6*u,0.4;
        0.4*u^3-1.4*u*E,1.4*E-3*0.2*u^2,1.4*u];
end



