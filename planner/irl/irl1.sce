//gen random weights
//get optimal policy

//get new optimal policy , add to set of policies
//--run for n times--
w=rand(H*H+2*H+3,1);
pls=cell();
pls(1).entries=qlearn(w);
for i=1:20
    
end
//max sum of diff -> gets new weights
//A->2*(n+w)x(n+w) -n number of policies, w features
//B -2*x 1s, rest 0s
//A=[A1|A2;A3|A4;A5|A6;A7|A8]
//A1=0
//A2=unit
//A3=0
//A4=unit
//A5=-unit
//A6=V(e)-V(mu)
//A7=-unit
//A8=-2*[V(e)-V(mu)
