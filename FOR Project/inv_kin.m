function Q_inv = inv_kin(pos)
n_joints = 6;
px=pos(1);
py=pos(2);
pz=pos(3);
alpha = pos(4); 
beta=pos(5);
gama = pos(6);
global m6r;


%Rotation matrices corresponding to the moving euler angles
Rx = [1,0,0;0,cos(alpha),-sin(alpha);0,sin(alpha),cos(alpha)];
Ry = [cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];
Rz=  [cos(gama),-sin(gama),0;sin(gama),cos(gama),0;0,0,1];


Goal = [Rx*Ry*Rz,[px;py;pz]]; % First 3 rows of the transformation  matrix for given end effector position and orientation
syms q [1 n_joints]
tn = Tn(q); % Transformation matrix (0T6) with joint angles as variables 
e=(tn(1:3,:) -Goal); % matrix of equations to be solved 

%set of initial estimates to try with (as fsolve is sensitive to initial estimate)
EST=zeros(4^n_joints,n_joints);
for i=1:(4^n_joints)-1
    k=[(num2str(dec2base(i,4))-'0')].*(pi/2);
    EST(i+1,1:length(k))=k;
end

F=(matlabFunction(e));
options=optimoptions("fsolve","Algorithm","levenberg-marquardt","Display","off");

for i= 1:height(EST) %iterating through different set of initial estimates
[sol,fval,exitflag]=fsolve(@(a)F(a(1),a(2),a(3),a(4),a(5),a(6)),EST(i,:),options);
if(exitflag==1)
    Q_inv = sol;
    show(m6r,sol);
    return;     % exits the function when a solution is found
end
end

% when no solution is found, message is displayed and returns empty array
disp("Given position and orientation is not attainable");  
Q_inv=[];

end