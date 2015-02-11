use strict;
use 5.010;
use constant H => 5;
use constant P1 => .1;
use constant P2 => .05;

for (my $i=0;$i<=10;$i++) {
	open FILE, ">", "gen$i.dat" or die $!;
	my @barr;
	my @parr;
	my $j=int(rand(20)+10);
	print FILE "$j\n"; 
	for (my $t=0;$t<=$j*3;$t++) {
		for(my $p=0;$p<=$j;$p++) {
			my $isBoxed;
			for (my $k=0;$k<scalar(@barr);$k++) {
				if ($p>=$barr[$k][0] && $p<=$barr[$k][1] && $t>=$barr[$k][2] && $t<=$barr[$k][3]) {
					$isBoxed=1;
					break;
				} else {
					if ($t>$barr[$k][3]) {
						splice @barr,$k,1;
						$k--;
					}
				}
			}
			if (!$isBoxed) {
				if (rand() <= P2) {
					#box
					my $size=int(rand(H-1)+1);
					if (rand() > .5) {
						for (my $k=0;$k<$size && $p+$k<=$j && $t+$k<=$j*3;$k++) {
							$parr[$t+$k][$p+$k]="X";
						}
					} else {
						for (my $k=0;$k<$size && $p+$k<=$j && $t+$k<=$j*3;$k++) {
							$parr[$t+$size-$k-1][$p+$k]="X";
						}
					}
				} elsif (rand() <= P2) {
					#trap
					for (my $k=0;$k<3 && $p+$k<=$j && $t+$k<=$j*3;$k++) {
						$parr[$t+$k][$p+$k]="X";
					}
					if ($p+3<=$j && $t+1<=$j*3) {
						$parr[$t+1][$p+3]="X";
					}
				} elsif (rand() <=P1) {
					#single car
					$parr[$t][$p]="X";
				}
			}
			if (!$parr[$t][$p]) {
				$parr[$t][$p]=".";
			}
		}
	}
	#write
	for (my $t=0;$t<=$j*3;$t++) {
		for(my $p=0;$p<=$j;$p++) {
			print FILE $parr[$t][$p];
		}
		print FILE "\n";
	}
	close FILE;
}
