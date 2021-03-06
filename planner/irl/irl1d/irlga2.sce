function y=rfs(w)
    wn=w/norm(w,2);
    vr=evalr(epls);
    plo=br(wn);
    vrp=evalr(plo);
    //y=vr-vrp;
    y=abs(vr-vrp);
    //y=zeros(1,ns);
    //for i=1:ns
    //    y(1,i)=(evalr(pls(i).entries)-vr)*wn;
    //end
endfunction
//gen random weights
//get optimal policy

//get new optimal policy , add to set of policies
//--run for n times--
//w=rand(ws,1);
//ws,ns have size
//pls=cell();
//pls(1).entries=qlearn(w);
ga_params = init_param();
ga_params = add_param(ga_params,'dimension',ws);
ga_params = add_param(ga_params,'minbound',-ones(ws,1));
ga_params = add_param(ga_params,'maxbound',ones(ws,1));
//for ns=1:20
    //find j -> min u(e)-u(j)
//    vr=evalr(epls);
//    u=zeros(ns,ws);
//    Q=eye(ws,ws);
//    C=zeros(ws,ns);
//    for j=1:ns
//        u(j,:)=evalr(pls(j).entries);
//        C(:,j)=(vr-u(j,:))';
//    end
//    //[mn,mj]=min(vr-u);
//    p=zeros(ws,1);
//    b=ones(ns,1);
//    xopt=qp_solve(Q,p,C,b,0);
pop_s=40;
//[pop_opt,fopt]=optim_nsga2(rfs,pop_s,10,.1,.7,%T,ga_params);
[pop_opt,fopt]=optim_moga(rfs,pop_s,10,.1,.7,%T,ga_params);
u=zeros(pop_s,1);
for i=1:pop_s
    u(i)=norm(fopt(i,:),2);
end    
[mu,mi]=min(u);
//[mu,ma]=min(u);
w=pop_opt(mi);
//wa=pop_opt(ma);
//pls(ns+1).entries=qlearn(w);
//end
//define function for evaluation of f

