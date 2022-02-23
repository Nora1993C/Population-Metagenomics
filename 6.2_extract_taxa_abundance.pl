use strict;
use Cwd ;
my $dir = getcwd;
$dir=~/(\w+)\/6_Gene-taxa-abundance/;
my $Pop=$1;
open Ref,"<","Hits_Gene_taxa.txt";
my %Hits;

while(<Ref>)
{
	chomp;
	my @temp=split /\t/;
	$Hits{$temp[0]}=$temp[6];
}

open In,"<","1_".$Pop."_gene.abun.txt";
open Out,">","2_".$Pop."_Hit_taxa_abun.txt";
printf Out "pop_id\tpop_gene_id\tType\trefgenome_ID\tGenus\tAbundance\n";
while(<In>)
{
	chomp;
	my @temp=split /\t/;
	if(exists $Hits{$temp[3]})
	{
		printf Out "%s\t%s\t%s\t%s\t%s\t%s\n",$temp[0],$temp[1],$temp[2],$temp[3],$Hits{$temp[3]},$temp[4],;
	}
}


