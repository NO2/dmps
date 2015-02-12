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
my $p=0;
print "$size\n";
for (my $t=0;($t<=($size*3- H)) && ($p<=$size);$t++) {
	$p=search($p,$t);
	print "$t $p\n";
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
	if ($cost[$step]>-1) {
		$p+=$step-1;
	}
	return $p;	
	#stay
	#move right
}
sub g {
	my ($p,$t,$d,$g,$a);
	($p,$t,$d,$a)=@_;
	#print "sr$p $t $d\n";
	if ($d==0) {
		return 0;
	}
	if ($p<0) {
		return -1;
	} elsif ($p>0 && $p<=$size) {
		#print $parr[$t][$p], " ", $parr[$t][$p]eq"X", "\n";
		if ($parr[$t][$p]eq"X") {
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
		if($p<=$size+1) {
			if ($parr[$t+1][$p]eq"X") {
				$g+=1;
			} else {
				$g+=2*$p;
			}
		} 
		return $g;
	}
	return -1;		
	#p,t,d
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
