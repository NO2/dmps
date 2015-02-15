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
	my ($p,$t,$f,$h,$s);
	($p,$t,$f,$s)=($sol->[0],$sol->[1],$sol->[2],$sol->[4]);
	push @cost,&f($p-1,$t+1,-1);
	push @cost,&f($p,$t+1,0);
	push @cost,&f($p+1,$t+1,1);
	&insert([$p-1,$t+1,$f+$cost[0],$f+$cost[0]+&g($p-1),$s."l"]);
	&insert([$p,$t+1,$f+$cost[1],$f+$cost[1]+&g($p),$s."s"]);
	&insert([$p+1,$t+1,$f+$cost[2],$f+$cost[2]+&g($p+1),$s."r"]);
	#foreach cost (use inf) add to sols based on f+g+current
	#
}
my @chars=split("", @sols[0][4]);
my $p=0;
print "0\n";
foreach (@chars) {
	if ($_p eq "l") {
		$p-=1;
	} elsif ($_p eq "r") {
		$p+=1;
	}
	print "$p\n";
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
sub insert {
	my $i;
	for ($i=0;$i<=$#sols;$i++) {
		if ($_[0][4]<$sols[$i][4]) {
			last;
		}
	}
	splice @sols,$i,0,$_[0];
}
