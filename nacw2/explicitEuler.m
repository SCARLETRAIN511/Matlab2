function [t,y] = explicitEuler(f,tspan,y0,h)
% Explicit Euler 

% Takes a function f, time span, initial condition and number of time step
% as input 

m = length(y0);
t = tspan(1):h:tspan(2); % Uniform grid 
N = length(t); % Number of grid points 
y = zeros(m,N); % Initialise variable representing numerical solution 
y(:,1) = y0; % Initial condition 

% This loop executes explicit Euler 
for i = 1:N-1
    y(:,i+1) = y(:,i) + h*f(t(i),y(:,i));
end
