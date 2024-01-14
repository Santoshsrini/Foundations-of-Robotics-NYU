function pos = fwd_kin(q)
    global m6r;
    a=eye(4,4);
    global dh;
    dh_t =dh(q); % DH table with the joint variables substituted
    p=[0;0;0];
    for i=1:length(q)
        a=a*T(dh_t(i,:)); %multiplying (i-1)T(i) at each iteration 
        p=[p,a(1:3,4)];
    end

    disp("Positions of Joints:");
    disp(p(:,1:6));
    disp("End effector position:")
    disp(p(:,7));

    %visualisation
    show(m6r,q);
end