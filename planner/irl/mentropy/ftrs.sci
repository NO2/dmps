function y=genf(p, t,  a) //p:state reached by action a at time t
//    if (p<0) then
//        y(0)=-1000;
//    else
//        y(0)=0;
//    end
    //0:current state
    //1:diagonal blockage
    //y=zeros(H*H+4*H+4,1);
//    cnt=1;
//    for i = -H:H
//        for j = abs(i):H+1
//            if (p+i<0) then
//                y(cnt)=-1;
//            else
//                y(cnt)=0;
//            end
//            if (p+i>0 & p+i<=gsize & t+j<=3*gsize-H) then //loadp should be executed first
//                if (strcmp(part(grid(t+1+j),p+i+1),"X")==0) then
//                    y(cnt)=-1;
//                elseif (strcmp(part(grid(t+2+j),p+i+1),"X")==0) then
//                    y(cnt)=-.5;
//                end
//            end
//            cnt=cnt+1;
//        end    
//    end
//    k=-sum(y,1)/49;
    y=zeros(ws,1);
    cnt=2;
    //y(1)=k;
    y(cnt)=0;
    //printf("%d %d %d %d\n",p,t,sa,a);
    if (p>0 & p<=gsize & t>0 & t<3*gsize) then //loadp should be executed first
        if (strcmp(part(grid(t+1),p+1),"X")==0) then
            y(1)=-1.000;
        elseif (strcmp(part(grid(t+2),p+1),"X")==0) then
            y(1)=-.05;
        //else
        //    y(1)=1;
        end
        if (strcmp(part(grid(t+1),p+1-a),"X")==0 & strcmp(part(grid(t),p+1),"X")==0) then
            y(cnt)=-1;
        end
    end
    //cnt=1;
    y(cnt+1)=abs(a);
    y(cnt+2)=0;
    if p==gsize+1 then
        y(cnt+2)=1000;
    end
endfunction
function rw=evalr(pls)
    //pls nx2 matrix, position and action
    //return a row
    rw=zeros(ws,1);
    sa=0;
    for t=1:size(pls,1)
        sa=sa+abs(pls(t));
        rw=rw+gm*genf(s,t,sa,pls(t));
    end
    rw=rw';
endfunction
