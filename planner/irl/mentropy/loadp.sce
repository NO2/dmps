H=5;
ws=4;
[fdg, err] = mopen("gen0.dat");
[fdp, err] = mopen("path0.dat");
gsize=strtod(mgetl(fdg,1));
grid=mgetl(fdg);
expert=strtod(mgetl(fdp));
epls=zeros(size(expert,1)-1,1);
for i=2:size(expert,1)
    epls(i-1)=expert(i)-expert(i-1);
end
//use part to search character
//define feature vectors for a state
//gen random weights
//find optimal strategy for weights ->write RL code add to policy list
//maximize weights for diff V
file("close", fdg);
file("close", fdp);
