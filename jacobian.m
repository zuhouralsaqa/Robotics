syms theta1 theta2 theta3 d1 d2 d3;  % Define symbolic variables

%% RR

a1 = 6; %link1 length
a2 = 6; %link2 length

x(theta1, theta2) = a1*cos(theta1) + a2*cos(theta1 + theta2);
y(theta1, theta2) = a1*sin(theta1) + a2*sin(theta1 + theta2);
z = 0;
alpha = 0;
beta = 0;
gama = 0;

%% jacobian from equations
Jacobian = [diff(x,theta1), diff(x,theta2), diff(x,theta3), diff(x,d1), diff(x,d2), diff(x,d3);
            diff(y,theta1), diff(y,theta2), diff(y,theta3), diff(y,d1), diff(y,d2), diff(y,d3);
            diff(z,theta1), diff(z,theta2), diff(z,theta3), diff(z,d1), diff(z,d2), diff(z,d3);
            diff(alpha,theta1), diff(alpha,theta2), diff(alpha,theta3), diff(alpha,d1), diff(alpha,d2), diff(alpha,d3);
            diff(beta,theta1), diff(beta,theta2), diff(beta,theta3), diff(beta,d1), diff(beta,d2), diff(beta,d3);
            diff(gama,theta1), diff(gama,theta2), diff(gama,theta3), diff(gama,d1), diff(gama,d2), diff(gama,d3)];
        
%% find velocity
syms  dtheta1 dtheta2 dtheta3 dd1 dd2 dd3

% velocity = [dX; dY; dZ; dalpha; dbeta; dgama];
Q_dot = [dtheta1; dtheta2; dtheta3; dd1; dd2; dd3];

velocity =  Jacobian * Q_dot

%% get after run
Vx(theta1, theta2) = - 6*dtheta2*sin(theta1 + theta2) - dtheta1*(6*sin(theta1 + theta2) + 6*sin(theta1));
Vy(theta1, theta2) = dtheta1*(6*cos(theta1 + theta2) + 6*cos(theta1)) + 6*dtheta2*cos(theta1 + theta2);
Vz =  0;
Valpha =  0;
Vbeta = 0;
Vgama = 0;
%%

% sol = solve(eqn, dX)
%dx = vpa(simplify(sol.dX))

v_x= subs(Vx, [theta1, theta2, dtheta1, dtheta2], [pi/2, pi/8, -1, 0.2])
eval(v_x)