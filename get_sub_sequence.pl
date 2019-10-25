#!/usr/bin/perl
use warnings;
use strict;

die "perl $0 <ref.fa> <pos_table> <expand_length[default=0]>

pos_table format as:
	chr	start	end
example:
14    105239224    105239224
5    112043580    112043580
11    108106405    108106405
"if(!$ARGV[1]);

my ($ref,$table,$expand);
$ref=$ARGV[0];
$table=$ARGV[1];
if(scalar(@ARGV) == 2)
{
	$expand=0;
}
else
{
	$expand=$ARGV[2];
}

my %hash;
my %chr_length;
$/=">";
open IN,"<$ref" || die $!;
<IN>;
while(<IN>)
{
	my @a = split /\n/;
	my $seqname = shift @a;
	my $seq = join("",@a);
	$seqname=~s/chr//;
	$hash{$seqname}=$seq;
	$chr_length{$seqname} = length($seq);
	#print "$seqname\t",length($seq),"\n";
}
close IN;
$/="\n";

open IN2,"<$table" || die $!;
while(<IN2>)
{
	chomp;
	my @infos =split/\s+/;
	$infos[0]=~s/chr//;
	if($infos[1]<=$chr_length{$infos[0]})
	{
		my $start = $infos[1]-$expand;
		my $end = $infos[2] + $expand;
		my $l = $infos[2]-$infos[1] + 1 + 2*$expand;
		my $sub_seq;
		if($expand==0)
		{
			$sub_seq = substr($hash{$infos[0]},$start-1,$l);
		}
		else
		{
			$sub_seq = substr($hash{$infos[0]},$start-1,$expand)."\n".substr($hash{$infos[0]},$infos[1]-1,$infos[2]-$infos[1]+1)."\n".substr($hash{$infos[0]},$infos[2],$expand);
		}
		my $name = ">chr$infos[0]\_$start\_$end\_$l";
		print $name,"\n",$sub_seq,"\n\n";
	}
}
close IN2;
