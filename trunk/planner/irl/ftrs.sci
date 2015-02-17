function y=genf(p, t, a) //p:state reached by action a at time t
//    if (p<0) then
//        y(0)=-1000;
//    else
//        y(0)=0;
//    end
    //0:current state
    //1:diagonal blockage
    cnt=0;
    for i = -H:H
        for j = abs(i):H+1
            if (p+i<0) then
                y(cnt)=-1000;
            else
                y(cnt)=0;
            end
            if (p+i>0 & p+i<=gsize) then //loadp should be executed first
                if (strcmp(part(grid(t+1+j),p+i+1),"X")==0) then
                    y(cnt)=-1000;
                elseif (strcmp(part(grid(t+2+j),p+i+1),"X")==0) then
                    y(cnt)=-5;
                end
            end
            cnt=cnt+1;
        end    
    end
    if (p>0 & p<=gsize) then //loadp should be executed first
//        if (strcmp(part(grid(t+1),p+1),"X")==0) then
//            y(0)=-1000;
//        elseif (strcmp(part(grid(t+2),p+1),"X")==0) then
//            y(0)=-5;
//        end
        if (strcmp(part(grid(t+1),p+1-a),"X")==0 & strcmp(part(grid(t),p+1),"X")==0) then
            y(cnt)=-1000;
        else
            y(cnt)=0;
        end
    end
    y(cnt+1)=p;
endfunction
