gm=.9;
alph=.7;
function z=qlearn(w)
    q=rand((gsize+2),3*gsize,3*gsize,3);
    for i=1:5000
        s=0;
        t=0;
        sa=0;
        while (s>=0 & s<=gsize & t<=3*gsize-H) 
            a=getact(s,t,sa,w);
            s2=s+a;
            //printf("%d %d %d\n",s,t,s2);
            if s2>=0 & s2<=gsize
                q(s+1,t+1,sa+1,a+2)=rw(s,t,sa,a,w)+gm*max(q(s2+1,t+2,sa+2,1),q(s2+1,t+2,sa+1,2),q(s2+1,t+2,sa+2,3));
            else
                q(s+1,t+1,sa+1,a+2)=rw(s,t,sa,a,w);
            end
            s=s2;
            t=t+1;
            sa=sa+abs(a);
        end
    end
    s=0;
    t=0;
    sa=0;
    while (s>=0 & s<=gsize & t<=3*gsize-H) 
        a=getacts(s,t,sa);
        z(t+1)=a;
        s=s+a;
        t=t+1;
        sa=sa+abs(a);
    end
    //disp(q);
endfunction
function r=rw(p,t,sa,a,w)
    y=genf(p+a,t+1,sa,a);
    //disp(w);
    //disp(size(y,1));
    //r=1;
    r=(y')*w;
endfunction
function a=getact(s,t,sa,w)
    for j=1:3
        r(j)=rw(s,t,sa,j-2,w);
    end
    if s>0 then
        [mr,a]=max(r);
    else
        [mr,a]=max(r(2:3));
        a=a+1;
    end
    //[mr,a]=max(r);
    a=a-2;
endfunction
function a=getacts(s,t,sa)
    //printf("%d %d\n",s,t);
    if s>0 then
        [mr,a]=max(q(s+1,t+1,sa+2,1),q(s+1,t+1,sa+1,2),q(s+1,t+1,sa+2,3));
    else
        [mr,a]=max(q(s+1,t+1,sa+1,2),q(s+1,t+1,sa+2,3));
        a=a+1;
    end
    a=a-2;
endfunction
function z=br(w)
    s=0;
    t=0;
    sa=0;
    while (s>=0 & s<=gsize & t<=3*gsize-H) 
        z(t+1)=s;
        a=getact(s,t,sa,w);
        s=s+a;
        t=t+1;
        sa=sa+abs(a);
    end
    z(t+1)=s;
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
