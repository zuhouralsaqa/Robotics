%% Define symbolic variables
syms theta1 theta2

% Define arm lengths
L1 = 6; % Length of the first arm
L2 = 6; % Length of the second arm

% Compute the end effector position
x = L1*cosd(theta1) + L2*cosd(theta1 + theta2);
y = L1*sind(theta1) + L2*sind(theta1 + theta2);

x_1 = L1*cosd(theta1);
y_1 = L1*sind(theta1);

% Create a figure and axes
figure;
axis([-2 7 -2 7]);
xlim([-2, 7]);
ylim([-2, 7]);
%axis equal;
hold on;
grid on;


% Loop variables
steps = [1, 2, 3, 4, 5, 6];
%t1_values = [81.7, 70.71, 61.06, 53, 46.3, 40.87];
%t2_values = [120, 118.68, 114.8, 108.66, 100.37];

% Draw the robotic arm
arm1 = plot(0, 0, 'b', 'LineWidth', 2);
arm2 = plot(0, 0, 'g', 'LineWidth', 2);
endpoint = plot(0, 0, 'ro', 'MarkerSize', 8);

%% Initialize the path arrays
path_x1 = [];
path_y1 = [];
theta_1 = [];
theta_2 = [];

%% Create a VideoWriter object
videoFile = 'assignment.mp4';
videoObj = VideoWriter(videoFile, 'MPEG-4');
videoObj.FrameRate = 10; % Set the frame rate (adjust as needed)
open(videoObj);


%% Update the plot
for s = steps
    % Update the arm position
    
    % find joint variables 
    
    x_value = (s-1)*6/5;
    y_value = 6;

    beta = atan(y_value/x_value)*180/pi;
    L = sqrt(x_value^2+y_value^2);
    t2 = acos(((L^2)-72)/72)*180/pi;
    theta_2 = [theta_2, t2];
    gama = asin(6*(sind(t2)/L))*180/pi;
    t1 = beta - gama;
    theta_1 = [theta_1, t1];
    
    x0 = 0;
    y0 = 0;

    x1 = subs(x_1, [theta1, theta2], [t1, t2]);
    y1 = subs(y_1, [theta1, theta2], [t1, t2]);

    x2 = subs(x, [theta1, theta2], [t1, t2]);
    y2 = subs(y, [theta1, theta2], [t1, t2]);

    set(arm1, 'XData', [x0, x1], 'YData', [y0, y1]);
    set(arm2, 'XData', [x1, x2], 'YData', [y1, y2]);
    set(endpoint, 'XData', double(x2), 'YData', double(y2));
    % Store the end effector position in the path arrays
    path_x1 = [path_x1, double(x2)];
    path_y1 = [path_y1, double(y2)];
    % Plot the manipulator path
    plot(path_x1, path_y1, 'r-', 'LineWidth', 1.5);
    drawnow;
    % Write the current frame to the video file
    frame = getframe(gcf);
    writeVideo(videoObj, frame);
    
end

% Plot the manipulator path
plot(path_x1, path_y1, 'r-', 'LineWidth', 1.5);

theta_1
theta_2
