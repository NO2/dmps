function d=eefc(w)
    z1s(gsize+2,:,:)=ones(z1s(gsize+2,:,:));
    for n=1:20
        for i=gsize+1:-1:1
            for t=3*gsize:-1:1
                for sa=3*gsize:-1:1
                    for j=1:3
                        //check valid action
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 then
                            z1a(i,t,sa,j)=exp(rw(i-1,t-1,sa-1,j-2))*z1s(s2,t+1,sa+abs(j-2));
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
                            z2a(i,t,sa,j)=exp(rw(i-1,t-1,sa-1,j-2))*z2s(i,t,sa);
                        end
                    end
                    z2s(i,t,sa)=sum(z2a(i,t,sa,:));
                end
            end
        end
    end
endfunction
