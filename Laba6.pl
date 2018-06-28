use strict;
use warnings;
use 5.010;
use utf8;

my $filename = 'C:\Laba_Perl\access.log';
open(my $fh, '<', $filename) or die "Не могу открыть файл '$filename' $!";
my $x = 0;
my $num = 0;
my %hash = ();
my @items;
sub F_1
{
	if ($_[0] =~ /crawler|webdav|evil|http|node|ahref|guzzleh|p(?:erl|ython|hp)|survey|nmap|curl|indy[\s\t]+library|urllib|spider|anyevent|masscan|cloud|zeus|zmeu|mor(?:f|ph)eus|fuck|scan|\=|mozilla\/4\.|jorgee|^[^\s]+$/i)
	{
		return 1;
	}
	return 0;
}
sub F_2
{
	if ($_[0] =~ /499 403/)
	{
		return 1;
	}
	return 0;
}
sub F_3
{
	if ($_[0] =~ /^\$|[:<>-]|\/\/|\.\.|\.(?:php|cgi|bs|pl)|sql|\.[^\/\s]+\/|\\x.+|backup|\/wp-[^-]|phpmyad|admin|cpanel|vhosts|p\/m\/a|bbs|xampp|/)
	{
		return 1;
	}
	return 0;
}
sub F_4
{
	if ($_[0] =~ /\/(?:README|FAQ)/)
	{
		return 1;
	}
	return 0;
}
sub F_5
{
	if ($_[0] =~ /https?\/\/:(?:mysite.fr|(?:www\.)?(?:google\.(?:com|ru|fr|hk|jp|co\.uk|br|cc))|yandex\.ru|bing\.com)\//)
	{
		return 0;
	}
	return 1;
}
while(my $line = <$fh>) 
{
	if ($line =~ /^(\d+\.\d+\.\d+\.\d+)\s+([^\s])+\s+([^\s]+)\s+\[([^\s\]]+)\s+([^\s\]]+)\]\s+"(?:(get|head|post)\s+)?([^"]+)"\s+(\d+)\s+\d+\s+"([^"]+)"\s+"([^"]+)"/) 
	{
		push @items, {
				"num" => $num,
				"ip" => $1,
				"blank" => $2,
				"user" => $3,
				"datetime" => $4,
				"timezone" => $5,
				"method" => $6,
				"request" => $7,
				"status" => $8,
				"referer" => $9,
				"user-agent" => $10
			};
	}
	$num++;
	
	$hash{ $line } = F_1($items[$num]{'user-agent'})+F_2($items[$num]{'status'}) + F_3($items[$num]{'request'}) + F_4($items[$num]{'request'}) + F_5($items[$num]{'referer'});	
}
foreach(sort {$hash{$b} <=> $hash{$a}} keys %hash)
{
	print $hash{$_},' = ',$_,"\n";
	$x++;
	if($x >= 50)
	{
		last;
	}
}