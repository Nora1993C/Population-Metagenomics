use strict;

use Cwd ;
my $dir = getcwd;
$dir=~/(\w+)\/3_Anno/;
my $Pop=$1;

my @files=glob("*.anno");
for my $file(@files)
{
	open In,"<",$file;
	$file=~/(.*)\.anno/;
	my $ID=$1;
	$file=~/(\S+)\.uniq\.pep/;
	my $indi=$1;
	open Out,">",$ID.".abun.txt";
	my %data;
	my $gene;
	while(<In>)
	{
		chomp;
		if(/^>(\S+)\(\S+\)/)
		{
			$gene=$1;
		}
		elsif(/^Type\s+(\S+)/)
		{
			$data{$gene}{"Type"}=$1;
		}
	}
	open Ref,"<","/home/Metagenome-2/relateiveAbundance/".$Pop."/".$indi.".clean.aln.relativeGeneAbundance.txt";
	while(<Ref>)
	{
		my @temp=split /\s+/;
		if(exists $data{$temp[0]})
		{
			$data{$temp[0]}{"Abun"}=$temp[1];
		}
	}
	for my $gid(sort keys %data)
	{
		printf Out "%s\t%s\t%s\n",$gid,$data{$gid}{"Type"},$data{$gid}{"Abun"};
	}
}


