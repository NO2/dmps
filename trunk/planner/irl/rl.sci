gm=.9;
alph=.7;
function z=qlearn(w)
    q=rand((gsize+2),3*gsize,3);
    for i=1:100
        s=0;
        t=0;
        while (s<=gsize) 
            a=getact(s,t,w);
            s2=s+a;
            q(s,t,a)=rw(s,t,a,w)+gm*max(q(s2,t+1,1),q(s2,t+1,1),q(s2,t+1,2));
            s=s2;
            t=t+1;
        end
    end
    s=0;
    t=0;
    while (s<=gsize) 
        a=getacts(s,t);
        z(t+1)=a;
        s=s+a;
        t=t+1;
    end
endfunction
function r=rw(s,t,a,w)
    y=genf(s,t,a);
    r=(y')*w;
endfunction
function a=getact(s,t,w)
    for j=1:3
        r(j)=rw(s,t,j-2,w);
    end
    [mr,a]=max(r);
    a=a-2;
endfunction
function a=getacts(s,t)
    [mr,a]=max(q(s,t,1),q(s,t,1),q(s,t,2));
    a=a-2;
endfunction
//func rw
//func getact
//pass weights
//will use features
//state defined by pXt?
//intitialize q(s,a) arbitrarily
//init intial state
//till s is goal state,repeat
//choose action by eps-greedy or some other method, just use func choose for now, take max q action
// ,update q=q+alpha*(r(s,a)+gamma*g(s')
