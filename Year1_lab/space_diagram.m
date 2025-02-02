clc
clear 
load('space.mat');
N=2150;
Nplanets=length(m);
dt=100000;


G=6.67e-11;
for ts=1:N
    for i=1:Nplanets
        F=[0,0,0];
        for j=1:Nplanets
            if i~=j
                %define relative position of the planet
                r=[x(j,ts)-x(i,ts);y(j,ts)-y(i,ts);z(j,ts)-z(i,ts)];
                modr=sqrt(sum(r.^2));
                %add force contribution of j body into i body
                F=F+G*m(i)*m(j)*r/modr^3;
            end
        end
        u(i,ts+1)=u(i,ts)+F(1)*dt/m(i);
        v(i,ts+1)=v(i,ts)+F(2)*dt/m(i);
        w(i,ts+1)=w(i,ts)+F(3)*dt/m(i);
        %get new positions
        x(i,ts+1)=x(i,ts)+u(i,ts)*dt+F(1)*dt^2/m(i);  
        y(i,ts+1)=y(i,ts)+v(i,ts)*dt+F(2)*dt^2/m(i);
        z(i,ts+1)=z(i,ts)+w(i,ts)*dt+F(3)*dt^2/m(i);
    end
    plot(x',y')
    hold on
    plot(x(:,ts+1),y(:,ts+1),'o')
    hold off
    axis equal
    pause(0.001)
    drawnow
end
