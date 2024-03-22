%% try out the func

% trajectory_planning(th_i, th_f, v_i, v_f, T_i, T_f, order, acc_i, acc_f)

C1 = trajectory_planning(20,80,  0,0,  0,5,  3)
C2 = trajectory_planning(80,25,  0,0,  5,10,  3)


%%  trajectory planning function
function C = trajectory_planning(theta_i, theta_f, velocity_i, velocity_f, time_i, time_f, polynomial_order, accelaration_i, accelaration_f)


    T = time_f - time_i;
    T2 = T^2;
    T3 = T^3;
    T4 = T^4;
    T5 = T^5;
    
    s = 0.01;
    time = time_i : s : time_f;
    
    syms t


    if polynomial_order == 5

        S_matrix = [1 0 0   0    0     0;
                    0 1 0   0    0     0;
                    0 0 2   0    0     0;
                    1 T T2  T3   T4    T5;
                    0 1 2*T 3*T2 4*T3  5*T4;
                    0 0 2   6*T  12*T2 20*T3];

        path_matrix=[theta_i; velocity_i; accelaration_i; theta_f; velocity_f; accelaration_f];


        parameters_matrix = linsolve(S_matrix,path_matrix);

        c0 = parameters_matrix(1);
        c1 = parameters_matrix(2);
        c2 = parameters_matrix(3);
        c3 = parameters_matrix(4);
        c4 = parameters_matrix(5);
        c5 = parameters_matrix(6);
        
        theta_func = c0 + c1*t + c2*t^2 + c3*t^3 + c4*t^4 + c5*t^5;
        velocity_func = diff(theta_func, 1);
        accelaration_func = diff(velocity_func, 1);
        
        theta = subs(theta_func,(time-time_i));
        velocity = subs(velocity_func, (time-time_i));
        accelaration = subs(accelaration_func, (time-time_i));

    else 

        S_matrix=[1  0  0    0;
                  0  1  0    0; 
                  1  T  T2   T3; 
                  0  1  2*T  3*T2];

        path_matrix=[theta_i; velocity_i; theta_f; velocity_f];


        parameters_matrix = linsolve(S_matrix,path_matrix);

        c0 = parameters_matrix(1);
        c1 = parameters_matrix(2);
        c2 = parameters_matrix(3);
        c3 = parameters_matrix(4);
        c4 = 0;
        c5 = 0;
        C = [c1;c2;c3;c4;c5];
       
        theta_func = c0 + c1*t + c2*t^2 + c3*t^3;
        velocity_func = diff(theta_func, 1);
        accelaration_func = diff(velocity_func, 1);
        
        theta = subs(theta_func, (time-time_i));
        velocity = subs(velocity_func, (time-time_i));
        accelaration = subs(accelaration_func, (time-time_i));
                
    end
    
    
    
    plot(time, theta, 'r-', 'linewidth', 3)
    hold on
    plot(time, velocity, 'g-','linewidth', 3 )
    hold on
    plot(time, accelaration, 'b-', 'linewidth', 3)
    
    legend({'position', 'velocity', 'accelaration'})
    
    grid on
    
end



