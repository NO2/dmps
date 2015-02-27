function d=eefc(wt)
    z1s(gsize+2,:,:)=ones(z1s(gsize+2,:,:));
    for n=1:20
        for i=gsize+1:-1:1
            for t=3*gsize-1:-1:1
                for sa=3*gsize-1:-1:1
                    for j=1:3
                        //check valid action
                        printf("%d %d %d %d\n",i,t,sa,j);
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 then
                            ep=exp(-rw(i-1,t-1,sa-1,j-2,wt));
                            printf("%d %d %d %d\n",s2,t+1,sa+abs(j-2),j);
                            z1s(i,t,sa);
                            ep=ep*z1s(s2,t+1,sa+abs(j-2));
                            z1a(i,t,sa,j)=ep;//*z1s(s2,t+1,sa+abs(j-2));
                        end
                    end
                    z1s(i,t,sa)=sum(z1a(i,t,sa,:));
                end
            end
        end
    end
    z2s(1,1,1)=1;
    for n=1:20
        for i=1:gsize+2
            for t=1:3*gsize
                for sa=1:3*gsize
                    for j=1:3
                        //check valid action
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 then
                            z2a(i,t,sa,j)=exp(-rw(i-1,t-1,sa-1,j-2,wt))*z2s(i,t,sa);
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
    d=zeros((gsize+2),3*gsize,3*gsize,3);
    for i=1:gsize+2
        for t=1:3*gsize
            for sa=1:3*gsize
                for j=1:3
                    s2=i+j-2;
                    if s2>0 & s2<=gsize+2 then
                        d(i,t,sa,j)=z2s(i,t,sa)*exp(-rw(i-1,t-1,sa-1,j-2,wt))*z1s(s2,t+1,sa+abs(j-2))/z1s(1,1,1);
                    end        
                end
            end
        end
    end
endfunction
