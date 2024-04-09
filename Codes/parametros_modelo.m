M = 0.076;                  % mass of the pendulum bob (kg)
m = 0.0035                  % mass of the pendulum rod (kg)
l = 0.37;                   % length of the pendulum rod (m)
lG = (M*l+0.5*m*l)/(M+m);   % location of pendulum mass center (m)
IO = 0.01056348;                 % estimate of pendulum mass moment of inertia (kg-m^2)
b = 0.00345481;
%b = 0.0017189;% estimate of viscous friction coefficient (N-m-s)
theta_ic = 0.56025;           % initial pendulum angular position (rad)
theta_dot_ic = 0;           % initial pendulum angular velocity (rad/s)
g = 9.81;                   % acceleration due to gravity (m/s^2)
