global H=5;
global ws=H*H+4*H+6;
[fdg, err] = fopen("gen0.dat");
[fdp, err] = fopen("path0.dat");
global gsize=str2double(fgetl(fdg));
global grid;
for i=1:gsize*3
	grid(i,:)=fgetl(fdg);
endfor
#grid=mgetl(fdg);
exp=fgetl(fdp);
i=1;
global expert;
while (exp!=-1)
	expert(i)=str2double(exp);
	i=i+1;
	exp=fgetl(fdp);
endwhile
#expert=strtod(mgetl(fdp));
global epls=zeros(size(expert,1)-1,1);
for i=2:size(expert,1)
    epls(i-1)=expert(i)-expert(i-1);
endfor
#//use part to search character
#//define feature vectors for a state
#//gen random weights
#//find optimal strategy for weights ->write RL code add to policy list
#//maximize weights for diff V
fclose(fdg);
fclose(fdp);
