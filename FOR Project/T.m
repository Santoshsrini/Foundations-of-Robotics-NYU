%returns (i-1)T(i) corresponding to the given row of the DH matrix (dh)
function t = T(dh)
theta=dh(1);
d=dh(2);
a=dh(3);
alpha=dh(4);
t=([cos(theta),-cos(alpha)*sin(theta),sin(alpha)*sin(theta),a*cos(theta);
    sin(theta),cos(alpha)*cos(theta),-sin(alpha)*cos(theta),a*sin(theta);
    0,sin(alpha),cos(alpha),d;
    0,0,0,1]);
end