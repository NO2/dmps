H=5;
[fdg, err] = mopen("gen0.dat");
[fdp, err] = mopen("path0.dat");
gsize=mgetl(fdg,1);
grid=mgetl(fdg);
expert=mgetl(fdp);
//use part to search character
//define feature vectors for a state
//gen random weights
//find optimal strategy for weights ->write RL code add to policy list
//maximize weights for diff V
file("close", fdg);
file("close", fdp);
