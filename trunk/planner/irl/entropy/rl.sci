gm=.9;
alph=.7;
function z=qlearn(w)
    q=rand((gsize+2),3*gsize,3);
    for i=1:5000
        s=0;
        t=0;
        while (s>=0 & s<=gsize & t<=3*gsize-H) 
            a=getact(s,t,w);
            s2=s+a;
            //printf("%d %d %d\n",s,t,s2);
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
    //disp(q);
endfunction
function r=rw(s,t,a,w)
    y=genf(s+a,t+1,a);
    //disp(w);
    //disp(size(y,1));
    //r=1;
    //wn=w/norm(w,2);
    r=(y')*w;//1003-1;
endfunction
function a=getact(s,t,w)
    for j=1:3
        r(j)=rw(s,t,j-2,w);
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
function a=getacts(s,t)
    //printf("%d %d\n",s,t);
    if s>0 then
        [mr,a]=max(q(s+1,t+1,1),q(s+1,t+1,2),q(s+1,t+1,3));
    else
        [mr,a]=max(q(s+1,t+1,2),q(s+1,t+1,3));
        a=a+1;
    end
    a=a-2;
endfunction
function z=br(w)
    s=0;
    t=0;
    //sa=0;
    while (s>=0 & s<=gsize & t<=3*gsize-H) 
        a=getract(s,t,w,H);
        s=s+a;
        t=t+1;
        z(t)=a;
        //sa=sa+abs(a);
    end
    //z(t+1)=a;
endfunction
function a=getract(s,t,w,d)
    r=zeros(3,1);
    for j=3:-1:1
        r(j)=rw2(s,t,j-2,w,d);
        //printf("%f ",r(j));
    end
    //printf("\n");
    if s>0 then
        [mr,a]=max(r(3:-1:1));
    else
        [mr,a]=max(r(3:-1:2));
        //a=a+1;
    end
    //[mr,a]=max(r);
    a=2-a;
endfunction
function r=rw2(s,t,a,w,d)
    r=0;
    rc=zeros(3,1);
    //printf("%d %d %d %d\n",s,t,a,d)
    if d==0 then
        r=w(4)*s/3;
    elseif s>=0 then

        r=rw(s,t,a,w);
        if s<gsize then
            for j=1:3
                rc(j)=rw2(s+a,t+1,j-2,w,d-1);
            end
            if s>0 then
                mr=max(rc(3:-1:1));
            else
                mr=max(rc(3:-1:2));
            end
            //printf("%d\n",mr);
            r=r+mr;
        else
            r=r+w(4)*s/3;
        end
    end
    //disp(w);
    //disp(size(y,1));
    //r=1;
    //r=(y')*w;
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

