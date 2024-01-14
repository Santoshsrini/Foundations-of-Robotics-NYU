function ws = PlotWorkspace(res)
    syms q [1 6];
    j=(Jacob());
    j=matlabFunction(j);
    j=@(x)(j(x(1),x(2),x(3),x(4),x(5),x(6))); % det(j) was found to be independent of q6
    % j is now a function that computes det(Jacobian) for given joint angles

    pos = Tn(q);
    pos = matlabFunction(pos(1:3,4)); 
    pos = @(x)(pos(x(1),x(2),x(3),x(4),x(5),x(6))) ; % pos is now a function that copmutes [px,py,pz] for given joint angle inputs

    disp("Workspace computation will take long time!");

    % joint variables are varied within the joint limits provided by the manufacturer
    for q1=0:res:360
        for q2=-118:res:120
            for q3 = -225:res:11
                for q4 = 0:res:360
                    for q5=-97:res:180               
                        for q6 = 0:res:360
                                if det(j([q1,q2,q3,q4,q5,q6])) <= 1e-5
                                    p=pos([q1,q2,q3,q4,q5,q6].*(pi/180));
                                    scatter3(p(1),p(2),p(3),'red');
                                    hold on
                                end
                         end
                    end
                end
            end 
        end
    end
    return;
end