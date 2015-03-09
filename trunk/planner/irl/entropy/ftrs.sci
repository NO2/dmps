function y=genf(p, t, a) //p:state reached by action a at time t
    y=zeros(ws,1);
    //cnt=2;
    //y(1)=k;
    //y(1)=0;
    if (p>0 & p<=gsize & t>0 & t<3*gsize) then //loadp should be executed first
        if (strcmp(part(grid(t+1),p+1),"X")==0) then
            y(1)=-1;
        elseif (strcmp(part(grid(t+2),p+1),"X")==0) then
            y(1)=-.005;
        //else
        //    y(1)=1;
        end
        if (strcmp(part(grid(t+1),p+1-a),"X")==0 & strcmp(part(grid(t),p+1),"X")==0) then
            y(2)=-1;
        end
    end
    //cnt=1;
    y(3)=-abs(a);
    //y(cnt+4)=0;
    //if p==gsize+1 then
    //    y(4)=1000;
    //end
    y(4)=a;
    y(5)=-1;
    //y(cnt+3)=1;
endfunction
function rw=evalr(pls)
    //pls nx2 matrix, position and action
    //return a row
    rw=zeros(ws,1);
    s=0;
    for t=1:size(pls,1)
        s=s+pls(t);
        rw=rw+gm*genf(s,t,pls(t));
    end
    //rw=rw/size(pls,1);
    rw=rw';
endfunction

