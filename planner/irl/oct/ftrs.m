function y=genf(p, t, a) #//p:state reached by action a at time t
#//    if (p<0) then
#//        y(0)=-1000;
#//    else
#//        y(0)=0;
#//    end
#    //0:current state
#    //1:diagonal blockage
	global ws grid H gsize;
    y=zeros(ws,1);
    cnt=1;
    for i = -H:H
        for j = abs(i):H+1
            if (p+i<0)
                y(cnt)=-1000;
            else
                y(cnt)=0;
            endif
            if (p+i>0 & p+i<=gsize & t+j<=3*gsize-H) #//loadp should be executed first
                if (strcmp(grid((t+1+j),p+i+1),"X")==0) 
                    y(cnt)=-1000;
                elseif (strcmp(grid((t+2+j),p+i+1),"X")==0) 
                    y(cnt)=-5;
                endif
            endif
            cnt=cnt+1;
        endfor 
    endfor
    y(cnt)=0;
    if (p>0 & p<=gsize)  #//loadp should be executed first
#//        if (strcmp(part(grid(t+1),p+1),"X")==0) then
#//            y(0)=-1000;
#//        elseif (strcmp(part(grid(t+2),p+1),"X")==0) then
#//            y(0)=-5;
#//        end
        if (strcmp(grid((t+1),p+1-a),"X")==0 & strcmp(grid((t),p+1),"X")==0) 
            y(cnt)=-1000;
        endif
    endif
    y(cnt+1)=p;
endfunction
function rw=evalr(pls)
    #//pls nx2 matrix, position and action
    #//return a row
	global ws gm;
    rw=zeros(ws,1);
    s=0;
    for t=1:size(pls,1)
        s=s+pls(t);
        rw=rw+gm*genf(s,t,pls(t));
    endfor
    rw=rw';
endfunction
