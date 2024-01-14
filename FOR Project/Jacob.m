function jac = Jacob()
global DH;
Z=[0;0;1];
P=[0;0;0];
t=eye(4,4);
for i = 1:(height(DH)-1)
    t = t*T(DH(i,:));
    Z=[Z,t(1:3,3)];
    P=[P,t(1:3,4)];
end
t=t*T(DH(height(DH),:));
Pn = t(1:3,4);
jac=[];
for i = 1:height(DH)
    jac=[jac,[cross(Z(:,i),Pn - P(:,i));Z(:,i)]];
end
end
