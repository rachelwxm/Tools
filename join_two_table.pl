#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;


my ($file1,$file2,$k1,$k2,$info1,$info2,$outfile,$help);
my $method = 1;
&Usage();

my @infos1=&MinusOne(split /,/,$info1);
my @infos2=&MinusOne(split /,/,$info2);
my @key1=&MinusOne(split /,/,$k1);
my @key2=&MinusOne(split /,/,$k2);
my $in1_length=scalar(@infos1);
my $in2_length=scalar(@infos2);

open IN2,"<$file2" || die $!;
my %hash2;
my %hash2_record;
while(<IN2>)
{
	chomp;
	my @in=split /\t/;
	my $key=join("_",@in[@key2]);
	@{$hash2{$key}}=@in[@infos2];
	$hash2_record{$key}=1;
}
close IN2;

open IN1,"<$file1" || die $!;
open OUT,">$outfile" || die $!;
if($method == 2)
{
	while(<IN1>)
	{
		chomp;
		my @in=split /\t/;
		my $key=join("_",@in[@key1]);
		if(exists $hash2{$key})
		{
			print OUT join("\t", @in[@infos1],"1", "1"),"\n";
			delete $hash2_record{$key};
		}
		else
		{
			print OUT join("\t",@in[@infos1],"1","0"),"\n";
		}
	}
	foreach my $key(keys %hash2_record)
	{
		print OUT join("\t",@{$hash2{$key}},"0","1"),"\n";
	}
}
else
{
	while(<IN1>)
	{
		chomp;
		my @in=split /\t/;
		my $key=join("_",@in[@key1]);
		if(exists $hash2{$key})
		{
			print OUT join("\t", @in[@infos1], @{$hash2{$key}}),"\n";
			delete $hash2_record{$key};
		}
		else
		{
			print OUT join("\t",@in[@infos1]),"\t" x $in2_length,"\n";
		}
	}

	foreach my $key(keys %hash2_record)
	{
		print OUT "\t" x $in1_length,join("\t",@{$hash2{$key}}),"\n";
	}
}
close IN1;
close OUT;


sub Usage{
	GetOptions(
		"f1:s"	=>	\$file1,
		"f2:s"	=>	\$file2,
		"k1:s"	=>	\$k1,
		"k2:s"	=>	\$k2,
		"info1:s"	=>	\$info1,
		"info2:s"	=>	\$info2,
		"out:s"	=>	\$outfile,
		"m:s"	=>	\$method,
		"h|help"	=>	\$help);
		# "help"	=>	\$help);

	my $usage="
Usage:	Join two tables
Author:	Wu Xiaomeng(wuxiaomeng\@simceredx.com)
Version: v0.1.1 181009
Release: for multi sample key in file1
Run:
	perl $0 [options]
	  --f1       file1
	  --f2       file2
	  --k1       key row num, split multi rows with ','.[default=1]
	  --k2       key row num, split multi rows with ','.[default=1]
	  --info1    output row(s) in file1 #[default=all rows]
	  --info2    same as above
	  --out      output file
      --m		 method, 2 for add 2 tag column past last
	  -h/--help  show this infomation

Example:
	perl $0 --f1 table1.txt --f2 table2.txt \
	--k1 1,2 --k2 2,3 \
	--info1 1,2,3,4 --info2 2,3,4,5 \
	--out output.txt
";
	$k1||=1;
	$k2||=1;

	if($help)
	{
		print $usage;
		exit();
	}
	if(!$file1 or !$file2)
	{
		print $usage;
		print "ERROR: NOT ENOUGH INPUT FILE(S)\n";
		exit();
	}
	if(!$outfile)
	{
		print $usage;
		print "ERROR: NOT OUTPUT FILE\n";
		exit();
	}
	if(!$info1 or !$info2)
	{
		print $usage;
		print "ERROR: NOT ENOUGH INPUT PARAMETER(S)\n";
		exit();
	}
}

sub MinusOne
{
	my @in=@_;
	my @out;
	map {push @out,($_-1)}@in;
	return @out;
}
