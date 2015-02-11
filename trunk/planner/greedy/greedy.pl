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
	for (my $i=0;$i<$#chars;$i++) {
		$parr[$j][$i]=$chars[$i];
	}
	$j++;
}
sub search {
	#move left
	my @cost;
	push @cost,&g($p-1,$t+1,H);
	push @cost,&g($p,$t+1,H);
	push @cost,&g($p+1,$t+1,H);
	my $step=&max(@cost);
	if ($cost[$step]>-1) {
		$p+=$step-1;
	}	
	#stay
	#move right
sub g {
	my ($p,$t,$d,$g);
	($p,$t,$d)=@_;
	if ($d==0) {
		return 0;
	}
	if ($p<-1) {
		return -1;
	}elsif ($p>0 && $p<=$size) {
		if ($parr[$p][$t]=='X') {
			return -1;
		}
	}
	my @cost;
	push @cost,&g($p-1,$t+1,$d-1);
	push @cost,&g($p,$t+1,$d-1);
	push @cost,&g($p+1,$t+1,$d-1);
	my $step=&max(@cost);
	if ($cost[$step]>-1) {
		$g+=$cost[$step];
		if ($parr[$p][$t+1]=='X') {
			$g+=1;
		}
		$g+=2*$p;
		return $g;
	}
	return -1;		
	#p,t,d
}
sub max {
	my $max=0;
	for (my $i=1;$i<$#_;$i++) {
		if ($_[$i]>$_[$max]) {
			$max=$i;
		}
	}
	return $max;
}
