% draw reachable workspace
syms theta1 theta2

%% Define variables 
L1 = 680; % Length of the first arm
L2 = 879; % Length of the second arm

%thetas
theta1_min = -105;
theta1_max = 140;
theta2_min = -205;
theta2_max = 40;

%plot
line_width = 2;
arm_line_width = 3;
end_point_MarkerSize = 8;
axis_gab_ratio = 1.1;

% Loop variables
step = 7;
video_framerate = 10;

%%
t1_values = theta1_min:step:theta1_max;
t2_values = theta2_min:step:theta2_max;


%% Compute the end effector position
x = L1*cosd(theta1) + L2*cosd(theta1 + theta2);
y = L1*sind(theta1) + L2*sind(theta1 + theta2);

x_1 = L1*cosd(theta1);
y_1 = L1*sind(theta1);

%% Create a figure and axes
figure;

xmin = -1*(L1+L2)*axis_gab_ratio;
xmax = (L1+L2)*axis_gab_ratio;

axis([xmin xmax xmin xmax]);
xlim([xmin, xmax]);
ylim([xmin, xmax]);
%axis equal;
hold on;
grid on;

xlabel('x (cm)')
ylabel('y (cm)')

ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';


% Draw the robotic arm
arm1 = plot(0, 0, 'b', 'LineWidth', arm_line_width);
arm2 = plot(0, 0, 'g', 'LineWidth', arm_line_width);
endpoint = plot(0, 0, 'ro', 'MarkerSize', end_point_MarkerSize);

%% Initialize the path arrays
path_x1 = [];
path_y1 = [];
path_x2 = [];
path_y2 = [];
path_x3 = [];
path_y3 = [];
path_x4 = [];
path_y4 = [];

%% Create a VideoWriter object
videoFile = 'robotic_arm_animation.mp4';
videoObj = VideoWriter(videoFile, 'MPEG-4');
videoObj.FrameRate = video_framerate; % Set the frame rate (adjust as needed)
open(videoObj);


%% Update the plot
for t1 = theta1_min
    for t2 = t2_values
        % Update the arm position
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
end

% Plot the manipulator path
plot(path_x1, path_y1, 'r-', 'LineWidth', line_width);

%% Update the plot
for t1 = theta1_max
    for t2 = t2_values
        % Update the arm position
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
        path_x2 = [path_x2, double(x2)];
        path_y2 = [path_y2, double(y2)];
        % Plot the manipulator path
        plot(path_x2, path_y2, 'm', 'LineWidth', line_width);
        drawnow;
        % Write the current frame to the video file
        frame = getframe(gcf);
        writeVideo(videoObj, frame);

    end
end

%% Update the plot
for t1 = t1_values
    for t2 = theta2_min
        % Update the arm position
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
        path_x3 = [path_x3, double(x2)];
        path_y3 = [path_y3, double(y2)];
        % Plot the manipulator path
        plot(path_x3, path_y3, 'b', 'LineWidth', line_width);
        drawnow;
        % Write the current frame to the video file
        frame = getframe(gcf);
        writeVideo(videoObj, frame);
        
    end
end

%% Update the plot
for t1 = t1_values
    for t2 = theta2_max
        % Update the arm position
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
        path_x4 = [path_x4, double(x2)];
        path_y4 = [path_y4, double(y2)];
        % Plot the manipulator path
        plot(path_x4, path_y4, 'y', 'LineWidth', line_width);
        drawnow;
        % Write the current frame to the video file
        frame = getframe(gcf);
        writeVideo(videoObj, frame);
        
    end
end

% Close the video file
close(videoObj);
