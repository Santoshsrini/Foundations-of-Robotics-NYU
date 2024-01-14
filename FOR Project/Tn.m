%Computes 0Tn of the given DH table
function tn =  Tn(q)
global m6r;
a=eye(4,4);
global dh;
dh_t =dh(q); % DH table with the joint variables substituted

for i=1:length(q)
    a=a*T(dh_t(i,:)); %multiplying (i-1)T(i) at each iteration 
end

tn = a;

end