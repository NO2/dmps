//gen random weights
//get optimal policy

//get new optimal policy , add to set of policies
//--run for n times--
w=rand(ws,1);
//ws,ns have size
pls=cell();
pls(1).entries=qlearn(w);
A2=eye(ws,ws);
A4=-eye(ws,ws);
for ns=1:20
    //A1=zeros(ws,ns);
    //A3=zeros(ws,ns);
    //A5=-eye(ns,ns);
    //A6 definition, sum 
    A6=zeros(ns,ws);
    vr=evalr(epls);//make it return a row
    for i=1:ns
        pler=evalr(pls(i).entries);
        A6(i,:)=vr-pler;
    end
    //A7=-eye(ns,ns);
    //A8=-2*A6;
    Ae=ones(1,ws);
    A=cat(1,A2,A4,Ae);
    B=ones(2*ws+1,1);
    B(ws+1:2*ws,1)=zeros(ws,1);
    //B(1:2*ws,1)=ones(2*ws,1);
    //c=zeros(ns+ws,1);
    //c(1:ns,1)=ones(ns,1);
    c=sum(A6,1)';
    //lb=zeros(ws,1);
    xopt=linpro(-c,A,B);//,lb);
    w=xopt;
    pls(ns+1).entries=qlearn(w);
end
//max sum of diff -> gets new weights
//A->2*(n+w)x(n+w) -n number of policies, w features
//B -2*w 1s, rest 0s
//A=[A1|A2;A3|A4;A5|A6;A7|A8]
//A1=0
//A2=unit
//A3=0
//A4=unit
//A5=-unit
//A6=V(e)-V(mu)
//A7=-unit
//A8=-2*[V(e)-V(mu)
//C n 1s, rest 0
