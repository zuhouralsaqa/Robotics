T_23 = inv(T_32);
T_34 = T_43.';
J_det = det(Jacobi);

% finnd the joint torques that balance with external force
Torque = (Jacobi.') * Force;

%%
x = optimvar('x');
y = optimvar('y');
prob = optimproblem;
prob.Objective = -x - y/3;
prob.Constraints.cons1 = x + y <= 2;
prob.Constraints.cons2 = x + y/4 <= 1;
prob.Constraints.cons3 = x - y <= 2;
prob.Constraints.cons4 = x/4 + y >= -1;
prob.Constraints.cons5 = x + y >= 1;
prob.Constraints.cons6 = -x + y <= 2;

sol = solve(prob,'Solver', 'intlinprog');

%%
syms y(t) a b
eqn = diff(y,t,2) == a^2*y;
Dy = diff(y,t);
%cond = y(a) == 1;
cond = [y(0)==b, Dy(0)==1];
ySol(t) = dsolve(eqn,cond);


%%
syms y(t) z(t)
eqns = [diff(y,t)==z, diff(z,t)==-y];
[ySol(t),zSol(t)] = dsolve(eqns);


%%
syms y(x)
eqn = diff(y, 2) == (1 - y^2)*diff(y) - y;
S = dsolve(eqn);

%%
syms y(x)
eqn = diff(y) == exp(-1/x)/x^2;
ySol(x) = dsolve(eqn);

%%
syms y(x)
dsolve(diff(y,x,2) == x*y);


%%
syms x y
diff(x*cos(x*y), y, 2);



