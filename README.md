# Tools
实用小用具合集，持续更新


## rv
替代rm命令，将欲删除文件先移到回收站，之后可定期清理。
回收站中自动以删除日期和小时整理。

效果如：

```shell
[wuxiaomeng@manage ~/TRASH ]
$ls -lthr
总用量 36
drwxr-xr-x  3 wuxiaomeng group 4096 9月   5 17:22 2019_09_05_05
drwxr-xr-x  3 wuxiaomeng group 4096 9月   6 17:33 2019_09_06_05
drwxr-xr-x  3 wuxiaomeng group 4096 9月   6 10:10 2019_09_06_10
drwxr-xr-x  3 wuxiaomeng group 4096 9月  18 11:57 2019_09_18_11
drwxr-xr-x  2 wuxiaomeng group 4096 9月  23 11:41 2019_09_23_11
drwxr-xr-x  3 wuxiaomeng group 4096 9月  29 16:44 2019_09_29_16
drwxr-xr-x 24 wuxiaomeng group 4096 9月  30 10:24 2019_09_30_10
```

## Transposition.pl
表格转置工具

使用方法：
```shell
usage:
perl Transposition.pl <table> > <out_table>
```

效果：

```shell
[wuxiaomeng@manage ~ ]
$cat table 
a	b	c
1	2	3
4	5	6
7	8	9
[wuxiaomeng@manage ~ ]
$Transposition.pl table 
a	1	4	7
b	2	5	8
c	3	6	9
```


## join_two_table.pl

合并两个表格。


执行方式
```reStructuredText
Run:
	perl ./join_two_table.pl [options]
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
	perl ./join_two_table.pl --f1 table1.txt --f2 table2.txt 
	--k1 1,2 --k2 2,3 
	--info1 1,2,3,4 --info2 2,3,4,5 
	--out output.txt
```

## get_sub_sequence.pl

从fa文件中提取目标区域的子序列。

```
perl get_sub_sequence.pl <ref.fa> <pos_table> <expand_length[default=0]>

pos_table format as:
	chr	start	end
example:
14    105239224    105239224
5    112043580    112043580
11    108106405    108106405
```
