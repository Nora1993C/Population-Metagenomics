use strict;

use Cwd ;
my $dir = getcwd;
$dir=~/(\w+)\/4_Abundance/;
my $Pop=$1;

my @Types=("all","L80","L90");
for my $type(@Types)
{
	my @files=glob("*.".$type.".abun.txt");
	my %Data;
	my %gene;
	for my $file(@files)
	{
		$file=~/(\S+)\.uniq\.pep/;
		my $indi=$1;

		#count the individuals with zero reads
        my @Gtypes=("cutC");     #different Types
		for my $gtype(@Gtypes)
		{
			$Data{$indi}{$gtype}=0;
			$gene{$gtype}=0;
		}
		open In,"<",$file;
		while(<In>)
		{
			chomp;
			my @temp=split /\s+/;
			$Data{$indi}{$temp[1]}=$Data{$indi}{$temp[1]}+$temp[2];
		}
	}	

	open Out,">","../5_results/".$Pop."_gene_indi.".$type.".abun.txt";
	printf Out "ID\t";
	for my $id(sort keys %gene)
	{
		printf Out "%s\t",$id;
	}
	printf Out "\n";
	for my $indi(sort keys %Data)
	{
		printf Out "%s\t",$indi;
		for my $id(sort keys %gene)
		{
			printf Out "%1.8f\t",$Data{$indi}{$id};
		}
		printf Out "\n";
	}
}

