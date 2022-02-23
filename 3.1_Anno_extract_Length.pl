use strict;
my @Lengths=(80,90);
for my $length(@Lengths)
{
	my @files=glob("*.pep.all.anno");
	for my $file(@files)
	{
		$file=~/(\S+)\.uniq\.pep\.all\.anno/;
		my $Indi=$1;
		my %Data;
		open In,"<",$file;
		open Out,">",$1.".uniq.pep.L".$length.".anno";
		my $id;
		while(<In>)
		{
			chomp;
			if(/^>(\S+)/)
			{
				$id=$1;
			}
			elsif(/^(\S+)\s+(\S+)/)
			{
				$Data{$id}{$1}=$2;
			}
		}
		for my $id(sort keys %Data)
		{
			if($Data{$id}{"QueryLength"}/$Data{$id}{"HitLength"}>=($length/100) && $Data{$id}{"HitLength"}/$Data{$id}{"QueryLength"}>=($length/100))
			{
				printf Out ">%s\n",$id;
				printf Out "BestHit\t%s\n",$Data{$id}{"BestHit"};
				printf Out "Type\t%s\n",$Data{$id}{"Type"};
				printf Out "Description\t%s\n",$Data{$id}{"Description"};
				printf Out "Evalue\t%s\n",$Data{$id}{"Evalue"};
				printf Out "QueryLength\t%s\n",$Data{$id}{"QueryLength"};
				printf Out "HitLength\t%s\n",$Data{$id}{"HitLength"};
				printf Out "HSPlength\t%s\n",$Data{$id}{"HSPlength"};
				printf Out "PercentIdentity\t%s\n\n",$Data{$id}{"PercentIdentity"};
			}
		}
	}
}
