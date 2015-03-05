//gen random weights
//get optimal policy

//get new optimal policy , add to set of policies
//--run for n times--
w=rand(ws,1);
//w=[rand();rand();-rand();rand();-rand();rand()]
//ws,ns have size
pls=cell();
pls(1).entries=qlearn(w);

for ns=1:20
    //find j -> min u(e)-u(j)
    vr=evalr(epls);
    u=zeros(ns,ws);
    Q=eye(ws,ws);
    C=zeros(ws,ns);
    for j=1:ns
        u(j,:)=evalr(pls(j).entries);
        C(:,j)=(vr-u(j,:))';
    end
    //[mn,mj]=min(vr-u);
    p=zeros(ws,1);
    b=ones(ns,1);
    xopt=qp_solve(Q,p,C,b,0);
    w=xopt;
    pls(ns+1).entries=qlearn(w);
end


