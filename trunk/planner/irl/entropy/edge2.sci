function d=eefc(wt)
    z1s=zeros((gsize+2),3*gsize,3*gsize);
    //z1sd=zeros((gsize+2),3*gsize,3*gsize);
    z1a=zeros((gsize+2),3*gsize,3*gsize,3);
    //z1ad=zeros((gsize+2),3*gsize,3*gsize,3);
    z2s=zeros((gsize+2),3*gsize,3*gsize);
    z2a=zeros((gsize+2),3*gsize,3*gsize,3);
    z1s(gsize+2,:,:)=ones(z1s(gsize+2,:,:));
    printf("p1\n");
    for n=1:20
        for i=gsize+1:-1:1
            for t=3*gsize-1:-1:1
                for sa=3*gsize-1:-1:1
                    for j=1:3
                        //check valid action
                        //printf("%d %d %d %d\n",i,t,sa,j);
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 //then
                            //z1s(27,81,81)
                            //printf("%d\n",s2);
                            z1a(i,t,sa,j)=exp(rw(i-1,t-1,sa-1,j-2,wt))*z1s(s2,t+1,sa+abs(j-2));
                        end
                    end
                    z1s(i,t,sa)=sum(z1a(i,t,sa,:));
                end
            end
        end
    end
    printf("p2\n");
    z2s(1,1,1)=1;
    for n=1:20
        for i=1:gsize+1
            for t=1:3*gsize-1
                for sa=1:3*gsize-1
                    for j=1:3
                        //check valid action
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 //then
                            z2a(i,t,sa,j)=exp(rw(i-1,t-1,sa-1,j-2,wt))*z2s(i,t,sa);
                        end
                    end
                    if (t>=2 & t<3*gsize) &  (sa>=2 & sa<3*gsize) then 
                        if i>=2 & i<=gsize+1 then
                            z2s(i,t,sa)=z2a(i-1,t-1,sa-1,3)+z2a(i+1,t-1,sa-1,1)+z2a(i,t-1,sa,2);
                        elseif i>=2 then
                            z2s(i,t,sa)=z2a(i-1,t-1,sa-1,3)+z2a(i,t-1,sa,2);
                        else
                            z2s(i,t,sa)=z2a(i+1,t-1,sa-1,1)+z2a(i,t-1,sa,2);
                        end   
                    end     
                end
            end
        end
    end
    printf("p3\n");
    d=zeros((gsize+2),3*gsize,3*gsize,3);
    for i=1:gsize+1
        for t=1:3*gsize-1
            for sa=1:3*gsize-1
                for j=1:3
                    s2=i+j-2;
                    if s2>0 & s2<=gsize+2 then
                        //printf("%d %d %d %d\n",i,t,sa,j);
                        d(i,t,sa,j)=z2s(i,t,sa)*exp(rw(i-1,t-1,sa-1,j-2,wt))*z1s(s2,t+1,sa+abs(j-2));///z1s(1,1,1);
                    end        
                end
            end
        end
    end
endfunction
