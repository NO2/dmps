use strict;
use 5.010;
use constant H => 5;
my @parr;
my $size;
for (my $k=0;$k<=10;$k++) {
	undef @parr;
	open FILE, "<", "gen$k.dat" or die $!;
	chomp($size = <FILE>);
	my ($line,$j,@chars);
	while(chomp($line= <FILE>)) {
		@chars = split //,$line;
		for (my $i=0;$i<=$#chars;$i++) {
			$parr[$j][$i]=$chars[$i];
			#print $parr[$j][$i];
		}
		$j++;
		#print "\n";
	}
	close FILE;
	open FILE, ">", "path$k.dat" or die $!;
	my $p=0;
	print FILE "0\n";
	for (my $t=0;($t<=($size*3- H)) && ($p<=$size) && $p>-1;$t++) {
		$p=search($p,$t);
		if ($p>-1) {
			print FILE "$p\n";
		}
	}
}
sub search {
	#move left
	my ($p,$t);
	my @cost;
	($p,$t)=@_;
	#print "sr$p $t\n";
	push @cost,&g($p-1,$t+1,H,-1);
	push @cost,&g($p,$t+1,H,0);
	push @cost,&g($p+1,$t+1,H,1);
	#print @cost , "\n";
	my $step=&max(@cost);
	$p+=$step-1;
	return $p;	
	#stay
	#move right
}
sub g {
	my ($p,$t,$d,$g,$a);
	($p,$t,$d,$a)=@_;
	#print "sr$p $t $d\n";
	if ($d==0) {
		return $p-$a;
	}
	if ($p<0) {
		$g-=$d*1000;
		return $g;
	} elsif ($p>0 && $p<=$size) {
		#print $parr[$t][$p], " ", $parr[$t][$p]eq"X", "\n";
		if ($parr[$t][$p]eq"X") { #hit
			$g-=1000;
			#return $g;
		}
		if (($parr[$t][$p-$a] eq "X") && ($parr[$t-1][$p] eq "X")) { #diagonal trap
			$g-=1000;
			#return $g;
		}
	}
	my @cost;
	push @cost,&g($p-1,$t+1,$d-1,-1);
	push @cost,&g($p,$t+1,$d-1,0);
	push @cost,&g($p+1,$t+1,$d-1,1);
	#print @cost , "\n";
	my $step=&max(@cost);
	$g+=$cost[$step];
	if($p<=$size+1) {
		if ($parr[$t+1][$p]eq"X") { #close to a hit
			$g-=5;
		}
		$g+=3*$a-abs($a)-1;
	} 
	return $g;		
	#p,t,d
}
sub max {
	my $max=$#_;
	for (my $i=0;$i<$#_;$i++) {
		if ($_[$i]>$_[$max]) {
			$max=$i;
		}
	}
	return $max;
}
