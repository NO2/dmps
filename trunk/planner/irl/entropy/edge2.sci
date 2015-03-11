function d=eefc(wt)
    z1s=zeros((gsize+2),3*gsize);
    //z1sd=zeros((gsize+2),3*gsize,3*gsize);
    z1a=zeros((gsize+2),3*gsize,3);
    //z1ad=zeros((gsize+2),3*gsize,3*gsize,3);
    z2s=zeros((gsize+2),3*gsize);
    z2a=zeros((gsize+2),3*gsize,3);
    z1s(gsize+2,:)=ones(z1s(gsize+2,:));
    printf("p1\n");
    for n=1:20
        for t=3*gsize-1:-1:1
            for i=gsize+1:-1:1
                //for sa=3*gsize-1:-1:1
                    for j=1:3
                        //check valid action
                        //printf("%d %d %d %d\n",i,t,sa,j);
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 //then
                            //z1s(27,81,81)
                            //printf("%d\n",s2);
                            z1a(i,t,j)=exp(rwn(i-1,t-1,j-2,wt))*z1s(s2,t+1);
                        end
                    end
                    z1s(i,t)=sum(z1a(i,t,:));
                    //z1a(i,t,:)=z1a(i,t,:)/z1s(i,t);
                    //printf("%d %d %f\n",i,t,z1s(i,t));
                //end
            end
            //z1s(:,t)=z1s(:,t)/sum(z1s(:,t));
        end
    end
    printf("%f p2\n",z1s(1,1));
    z2s(1,:)=ones(z2s(1,:));
    for n=1:20
        for t=1:3*gsize-1
            for i=1:gsize+1
                //for sa=1:3*gsize-1
                    for j=1:3
                        //check valid action
                        s2=i+j-2;
                        if s2>0 & s2<=gsize+2 //then
                            z2a(i,t,j)=exp(rwn(i-1,t-1,j-2,wt))*z2s(i,t);
                        end
                    end
                    //z2a(i,t,:)=z2a(i,t,:)/sum(z2a(i,t,:));
                    if (t>=2 & t<3*gsize) then 
                        if i>=2 & i<=gsize+1 then
                            z2s(i,t)=z2a(i-1,t-1,3)+z2a(i+1,t-1,1)+z2a(i,t-1,2);
                        elseif i>=2 then
                            z2s(i,t)=z2a(i-1,t-1,3)+z2a(i,t-1,2);
                        else
                            z2s(i,t)=z2a(i+1,t-1,1)+z2a(i,t-1,2);
                        end   
                    end     
                //end
            end
            //z2s(:,t)=z2s(:,t)/sum(z2s(:,t));
        end
    end
    printf("p3\n");
    d=zeros((gsize+2),3*gsize,3);
    for i=1:gsize+1
        for t=1:3*gsize-1
            //for sa=1:3*gsize-1
                for j=1:3
                    s2=i+j-2;
                    if s2>0 & s2<=gsize+2 then
                        //printf("%d %d %d %d\n",i,t,sa,j);
                        d(i,t,j)=z2s(i,t)*exp(rwn(i-1,t-1,j-2,wt))*z1s(s2,t+1)/z1s(1,1);
                    end        
                end
            //end
        end
    end
endfunction
function r=rwn(s,t,a,w)
    //y=genf(s+a,t+1,a);
    y=rw2(s,t,a,w,H);
    //disp(w);
    //disp(size(y,1));
    //r=1;
    //wn=w/norm(w,2);
    //r=(y')*w/1003-1;
    r=y/(gsize+2*H*ws)-1;//normalise between -1 & 0?
endfunction
