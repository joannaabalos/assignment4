function cur(n1,n2,val) % adds the stamp of a current source
% (current flowing from n1 to n2).
global b;

b(n1)=val;
b(n2)=-val;
end