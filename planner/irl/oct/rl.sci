gm=.9;
alph=.7;
function z=qlearn(w)
    q=rand((gsize+2),3*gsize,3);
    for i=1:100
        s=0;
        t=0;
        while (s<=gsize & t<=3*gsize-H) 
            a=getact(s,t,w);
            s2=s+a;
            if s2>=0
                q(s+1,t+1,a+2)=rw(s,t,a,w)+gm*max(q(s2+1,t+2,1),q(s2+1,t+2,2),q(s2+1,t+2,3));
            else
                q(s+1,t+1,a+2)=rw(s,t,a,w);
            end
            s=s2;
            t=t+1;
        end
    end
    s=0;
    t=0;
    while (s>=0 & s<=gsize & t<=3*gsize-H) 
        a=getacts(s,t);
        z(t+1)=a;
        s=s+a;
        t=t+1;
    end
endfunction
function r=rw(s,t,a,w)
    y=genf(s+a,t+1,a);
    //disp(w);
    //disp(size(y,1));
    //r=1;
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
    printf("%d %d\n",s,t);
    [mr,a]=max(q(s+1,t+1,1),q(s+1,t+1,2),q(s+1,t+1,3));
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
