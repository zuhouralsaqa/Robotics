function F = rotation_fun(sol)

global raw1_val raw2_val raw3_val


R = zeros(3,3);
R(1,1) = raw1_val;
R(2,2) = raw2_val;
R(3,3) = raw3_val;

R(1,2) = sol(1);
R(1,3) = sol(2);
R(2,1) = sol(3);
R(2,3) = sol(4);
R(3,1) = sol(5);
R(3,2) = sol(6);


F(1) = (R(1,1)^2) + (R(1,2)^2) + (R(1,3)^2) - 1;
F(2) = (R(2,1)^2) + (R(2,2)^2) + (R(2,3)^2) - 1;
F(3) = (R(3,1)^2) + (R(3,2)^2) + (R(3,3)^2) - 1;

F(4) = dot(R(:,1), R(:,2));
F(5) = dot(R(:,2), R(:,3));
F(6) = dot(R(:,3), R(:,1));

end
