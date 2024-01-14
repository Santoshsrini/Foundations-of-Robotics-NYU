function F = joint_torques(pos,fext)

    %obtaining jacobian matrix as a function
    j=Jacob();
    j=matlabFunction(j);
    j=@(x)(j(x(1),x(2),x(3),x(4),x(5),x(6)));


    q = inv_kin(pos); %obtaining joint angles correspoding to the given end effector position and orientation
    if isempty(q) 
        return; %exits if the given position is not reachable
    else 
        J = j(q);
        if det(J)==0  %singular point
            disp("Given position is a singular point");
        else
            F = -J'*fext'; %computing joint torques
        end
    end
end