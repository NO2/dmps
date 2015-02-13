use strict;
use 5.010;
use constant H => 5;

open FILE, "<", "gen0.dat" or die $!;
my @parr;
my $size;
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
my @sols;
push @sols,[0,0,0,&g(0),""];
while (@sols[0][0]<=$size && @sols[0][2]>=0) {
	#expand top state, pop, put back new states in sorted order
	#expand with possibility rules (diagonal/occupancy)
	#closeness gets cost addition
	#pop current state
	my $sol=shift @sols;
	&insert([$sol->[0]-1,$sol->[1]+1,$sol->[2]+&f($sol->[0]-1,$sol->[1]+1,-1),&g($sol->[0])]
	push @cost,&f($p-1,$t+1,-1);
	push @cost,&f($p,$t+1,0);
	push @cost,&f($p+1,$t+1,1);
	#foreach cost (use inf) add to sols based on f+g+current
	#
}
#my $p=0;
#print "0\n";
#for (my $t=0;($t<=($size*3- H)) && ($p<=$size) && $p>-1;$t++) {
#	$p=search($p,$t);
#	if ($p>-1) {
#		print "$p\n";
#	}
#}
sub search {
	#move left
	my ($p,$t);
	my @cost;
	($p,$t)=@_;
	print "sr$p $t\n";
	push @cost,&g($p-1,$t+1,H,-1);
	push @cost,&g($p,$t+1,H,0);
	push @cost,&g($p+1,$t+1,H,1);
	print @cost , "\n";
	my $step=&max(@cost);
	if ($cost[$step]>-1000) {
		$p+=$step-1;
	} else {
		return -1;
	}
	return $p;	
	#stay
	#move right
}
sub f {
	my ($p,$t,$g,$a);
	($p,$t,$a)=@_;
	#print "sr$p $t $d\n";
	if ($p<0) {
		return -1000;
	} elsif ($p>0 && $p<=$size) {
		#print $parr[$t][$p], " ", $parr[$t][$p]eq"X", "\n";
		if ($parr[$t][$p]eq"X") { #hit
			return -1000;
		}
		if (($parr[$t][$p-$a] eq "X") && ($parr[$t-1][$p] eq "X")) { #diagonal trap
			return -1000;
		}
	}
	#print @cost , "\n";
	if($p<=$size+1) {
		if ($parr[$t+1][$p]eq"X") { #close to a hit
			$g+=5;
		}
		$g+=abs($a);
		return $g;
	}
	return -1000;		
	#p,t,d
}
sub g {
	return 2*($size+1-$_[0]);
}
sub max {
	my $max=0;
	for (my $i=1;$i<=$#_;$i++) {
		if ($_[$i]>$_[$max]) {
			$max=$i;
		}
	}
	return $max;
}
sub insert {
}
