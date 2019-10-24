#!/usr/bin/perl
use warnings;
use strict;

die "usage:
Usage:	Transposition table
Author:	Wu Xiaomeng(wuxiaomeng\@simceredx.com)
Version: v0.1.0 

perl $0 <table>\n" if(!$ARGV[0]);

my @table;
my $c=0;
while(<>){
	chomp;
	my @a=split /\t/;
	for my $i(0..$#a){
		$table[$i][$.-1]=$a[$i]
	}
}
foreach(@table)
{
	print join("\t",@{$_}),"\n";
}

