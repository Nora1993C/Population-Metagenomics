use strict;
use Cwd ;
my $id;
my $dir = getcwd;
$dir=~/(\w+)\/6_Gene-taxa-abundance/;
my $Pop=$1;

open Out,">","1_".$Pop."_gene.abun.txt";

my @files=glob("*.hit.abun.txt");
for my $file(@files)
{
	open In,"<",$file;
	$file=~/(\S+).uniq.pep.all.hit.abun.txt/;
	$id =$1;
	while(<In>)
	{
		chomp;
		my @temp=split /\t/;
		printf Out "%s\t%s\t%s\t%s\t%s\n",$id,$temp[0],$temp[1],$temp[3],$temp[2];
	}
}

