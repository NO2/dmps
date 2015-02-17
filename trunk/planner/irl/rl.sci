gamma=.9;
alpha=.7;
function z=qlearn(w)
    q=rand((gsize+2),3*gsize,3);
    s=0;
    t=0;
    for i=1:100
        while (s<=gsize) 
            a=getact(s,t,w);
            s2=s+a;
            q(s,t,a)=rw(s,t,a,w)+gamma*max(q(s2,t+1,1),q(s2,t+1,1),q(s2,t+1,2));
        end
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
