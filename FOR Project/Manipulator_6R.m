%Run this section to initialise robot parameters and 3d model

clc; 
clear all;
global m6r; %Robot object that will be used in some functions in this package 
global dh; % dh function that can be substituted with 
global DH; % DH table  

syms q [1 6], % symbolic joint variables

% the DH table
DH=[q(1),26.7,0,-pi/2;
    q(2)-1.38492,0,28.94866,0;
    q(3)+1.3849179,0,7.75,-pi/2;
    q(4),34.25,0,pi/2;
    q(5),0,7.6,-pi/2;
    q(6),9.9,33.5,0
    ];

% DH table function
dh = matlabFunction(DH);
dh=@(x)(dh(x(1),x(2),x(3),x(4),x(5),x(6)));

% For robot visualisation
m6r = importrobot("Xarm6_description\urdf\Xarm6.xacro",DataFormat="row"); %importing the 3D model of the manipulator 
%% 


%fwd_kin(q) returns the positions of each joint and end effector by taking the array of joint angles as input
fwd_kin([0,0,0,0,0,0]);

%inv_kin(pos) returns joint angles for a given input of array containing
%end effector position (px,py,pz), followed by the X-Y-Z moving euler angles (radians) to describe end effector's orientation  
Q=inv_kin([0,0,0,0,0,0]);


%%Computing joint angular velocities 
%Takes end effector position and orientation (moving XYZ Euler angles) (6 x 1 array) and end
%effector's linear and angular velocities (6 x 1 array) as inputs and
%returns joint angular velocities if solution exists
qd = joint_vel([50,10,20,0,pi/2,pi/4],[10;0;0;0;0;0]);

%%Computing joint torques
%Takes end effector position and orientation (moving XYZ euler angles) (6 x 1 array) and external force and moments
% on the end effector (6 x 1 array) as inputs and returns joint torques if solution exists
Tau = joint_torques([50,10,20,0,pi/2,pi/4],[-10;0;0;0;0;0]);


show(m6r,zeros(1,6)); % displaying the robot with joint angle inputs as the second parameter (home configuration in this example)

%PlotWorkspace(20); % For visualising the workspace of the manipulator. Input is the resolution of the joint angles (in degrees)










