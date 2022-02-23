use strict;

use Cwd ;
my $dir = getcwd;
$dir=~/(\w+)\/3_Anno/;
my $Pop=$1;

my @Types=("all","L80","L90");
for my $type(@Types)
{
	my @files=glob("*.".$type.".anno");
	my %Data;
	my %gene;
	for my $file(@files)
	{
		$file=~/(\S+)\.uniq\.pep/;
		my $indi=$1;

		#count the individuals with zero reads
        my @Gtypes=("cutC");      #different Types
		for my $gtype(@Gtypes)
		{
			$Data{$indi}{$gtype}=0;
			$gene{$gtype}=0;
		}
		open In,"<",$file;
		while(<In>)
		{
			chomp;
			if(/Type\s+(\w+)/)
			{
				$gene{$1}=1;
				$Data{$indi}{$1}=$Data{$indi}{$1}+1;
			}
		}
	}	

	open Out,">","../5_results/".$Pop."_gene_indi.".$type.".txt";
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
			printf Out "%d\t",$Data{$indi}{$id};
		}
		printf Out "\n";
	}
}

for my $type(@Types)
{
	open Out,">","../5_results/".$Pop.".uniq.pep.".$type.".anno";
	my @files=glob("*.".$type.".anno");
	for my $file(@files)
	{
		open In,"<",$file;
		while(<In>)
		{
			printf Out "%s",$_;
		}
	}
}
