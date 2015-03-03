//gen random weights
//get optimal policy

//get new optimal policy , add to set of policies
//--run for n times--
w=rand(ws,1);
lmd=0.5;
//ws,ns have size
//pls=cell();
//pls(1).entries=qlearn(w);

for ns=1:20
    //compute Da
    z1s=zeros((gsize+2),3*gsize,3*gsize);
    //z1sd=zeros((gsize+2),3*gsize,3*gsize);
    z1a=zeros((gsize+2),3*gsize,3*gsize,3);
    //z1ad=zeros((gsize+2),3*gsize,3*gsize,3);
    z2s=zeros((gsize+2),3*gsize,3*gsize);
    z2a=zeros((gsize+2),3*gsize,3*gsize,3);
    Da=eefc(w);
    //compute gradient
    fs=evalr(epls);
    dw=fs';
    for i=1:gsize+2
        for t=1:3*gsize
            for sa=1:3*gsize
                for j=1:3
                    dw=dw-Da(i,t,sa,j)*genf(i-1+j-2,t,sa-1,j-2);//rw(i-1,t-1,sa-1,j-2,w);
                end
            end
        end
    end
    //update weights
    //w=w.*exp(lmd*dw/ns);
    w=w-lmd*dw/ns
    printf("%d\n",dw);
end
//pls(ns+1).entries=qlearn(w);

