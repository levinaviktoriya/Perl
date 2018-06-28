use strict;
use warnings;
use 5.010;
use utf8;

my $filename = 'C:\Laba_Perl\access.log';
my %hash = ();

open(my $fh, '<', $filename) or die "Не могу открыть файл '$filename' $!";
while (my $line = <$fh>)
{
    if ($line =~ /(\d+\.\d+.\d+.\d+)/)
    {
        if(exists($hash{ $1 }))
        {
            $hash{ $1 }++;
        }
        else
        {
            $hash{ $1 } = 1;
        }
    }
}

my $x = 1;
foreach(sort {$hash{$b} <=> $hash{$a}} keys %hash)
{
    print $_,' = ',$hash{$_},"\n";
    $x++;
    if($x > 10)
    {
        last;
    }
}