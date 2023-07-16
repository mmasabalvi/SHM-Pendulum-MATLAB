

% Precautions:

% 1) Don't Change the file Name Else program will run only once and will not
%    work on user choice


%---------------- Simple Pendulum Simulation-------------


% For the next 6 statements using disp command of Matlab to display on
% command window


% Getting input from user to input Angular displacement and velocity
% using input command to get input from user

displacement = input("Enter initial angular displacement (in radians): ");
velocity = input("Enter initial angular velocity (in radians per second): ");

% Defining parameters
g = 9.81;   %  Acceleration due to gravity (m/s^2)
L = 1;      %  Length of pendulum (m)
M = 1000;   %  Mass of pendulum (g)

% Define time range
% 0 to 20s
tspan = [0 20]; % Time interval for simulation (s) 

% Defining initial conditions
y0 = [displacement velocity];

%This equation is derived from by hand solution which defines the systems
%of differential equations that describes the motion of simple pendulum
eq = @(t,y) [y(2); -(g/L)*sin(y(1))];


% Solving differential equation using built in function of matlab

%-----------syntax of ode45 to solve ordinary DE---------  
% =============[T,Y] = ode45(ODEFUN,TSPAN,Y0)  ====================

%   ODEFUN means ODE and TSPAN defines time
%   interval and Y0 replaced by initail conditions

[t,y] = ode45(eq, tspan, y0);

% Plot results
plot(t, y(:,1), 'LineWidth', 2);  % ploting 
xlabel('Time (t) (s)');
ylabel('Angular Displacement (rad)');
title('Project : Simple Pendulum Simulation');
grid on;


% Time period of simple Pendulum
T = 2*pi*sqrt(L/g);
 

% ------------------- Animation of Simple Pendulum----------------
% Creating  figure
figure(); % this will open new window for animation
hold on;

axis equal;
% Ensuring that the aspect ratio of the plot is equal along the x- and y-axes.
axis([-1.0 1.0 -1.0 1.0]);  % Setting axis 

% Initialize plot and text objects
p = plot(0,0,'yo','MarkerFaceColor','k'); % yo representing bob's color
% p Black Circle bob

% l is the black line representing pedululum rod
l = plot([0,0],[0,0],'r-'); 
% r- representing string color that is holding pendulum

% text function is creating text object
t = text(-0.2,0.2,"Timer: 0.0 s"); % timer initial position from (-0.2,0.2)
% Note here Timer label is at position (-0.2,0.2)

%------------------- Animating pendulum motion--------------

% for loop iterates over each time step of the simulation
for i = 1:length(y)
    % Update plot and text objects
    x_position = L*sin(y(i,1));
    y_position = -L*cos(y(i,1));
    
    % set function is updating the positions of x and y corrdinates uf the
    % p and l objects using the XData and YData 
    set(p,'XData',x_position,'YData',y_position);
    set(l,'XData',[0,x_position],'YData',[0,y_position]);
    
    % sprintf function is used to format the text
    set(t,'String',sprintf('Timer: %.2f s',tspan(1)+i*(tspan(2)-tspan(1))/length(y)));
    
   % drawnow function is updating the figure window with new plot i.e p and
   % l objects 
    drawnow;
    
    % pause to add a short delay control the animation
    pause(0.1);
end

% Setting the  final timer value


set(t,'String',sprintf('Timer: %.2f s',tspan(2)));

% Asking the user if they want to run another query
choice = input("Do you want to run another query? (y/n): ", 's');
if choice == 'y'
    % Clear the current figure and the command window
    clf;
    clc;
    % Restart the program name of the project file will run again
    run('project.m');
else
    % else displaying prompt and exiting 
    % End the program
        disp("Thank you for using the Simple Pendulum Simulation!");
end


% Else program can aslo be plot with the following solution equation 
% This equation is obtained by hand solution 
%In this program we used ode45 function to solve ordinary differential
%equation Although the results are same with both solutions

% Equation obtained by hand is 
% theta = dispacement*cos((sqrt(g/l)+velocity./sqrt(g/l)*sin(sqrt(g/l))
% Note Both are giving equal results

