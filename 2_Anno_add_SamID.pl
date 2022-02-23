use strict;
my @files=glob("*.anno");
for my $file(@files)
{
	open In,"<",$file;
	$file=~/(\S+).uniq.pep.anno/;
	open Out,">","../3_Anno/".$1.".uniq.pep.all.anno";
	my $SamID=$1;
	while(<In>)
	{
		chomp;
		if(/^>/)
		{
			printf Out "%s(%s)\n",$_,$SamID;
		}
		else
		{
			printf Out "%s\n",$_;
		}
	}
}
