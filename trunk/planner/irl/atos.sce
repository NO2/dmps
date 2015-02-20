plo=pls(20).entries;
s=zeros(size(plo,1)+1,1);
for j=1:size(s,1)-1
    s(j+1)=s(j)+plo(j);
end
disp(s);
