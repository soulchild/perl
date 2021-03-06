
BEGIN {
    unless ("A" eq pack('U', 0x41)) {
	print "1..0 # Unicode::Collate " .
	    "cannot stringify a Unicode code point\n";
	exit 0;
    }
    if ($ENV{PERL_CORE}) {
	chdir('t') if -d 't';
	@INC = $^O eq 'MacOS' ? qw(::lib) : qw(../lib);
    }
}

use Test;
BEGIN { plan tests => 49 };

use strict;
use warnings;
use Unicode::Collate::Locale;

ok(1);

#########################

my $objHaw = Unicode::Collate::Locale->
    new(locale => 'HAW', normalization => undef);

ok($objHaw->getlocale, 'haw');

$objHaw->change(level => 1);

ok($objHaw->lt('a', 'e'));
ok($objHaw->lt('e', 'i'));
ok($objHaw->lt('i', 'o'));
ok($objHaw->lt('o', 'u'));
ok($objHaw->lt('u', 'h'));
ok($objHaw->lt('h', 'k'));
ok($objHaw->lt('k', 'l'));
ok($objHaw->lt('l', 'm'));
ok($objHaw->lt('m', 'n'));
ok($objHaw->lt('n', 'p'));
ok($objHaw->lt('p', 'w'));
ok($objHaw->lt('w', "\x{2BB}"));
ok($objHaw->gt('b', "\x{2BB}"));

# 15

$objHaw->change(level => 2);

ok($objHaw->eq('a', 'A'));
ok($objHaw->eq('e', 'E'));
ok($objHaw->eq('i', 'I'));
ok($objHaw->eq('o', 'O'));
ok($objHaw->eq('u', 'U'));
ok($objHaw->eq('h', 'H'));
ok($objHaw->eq('k', 'K'));
ok($objHaw->eq('l', 'L'));
ok($objHaw->eq('m', 'M'));
ok($objHaw->eq('n', 'N'));
ok($objHaw->eq('p', 'P'));
ok($objHaw->eq('w', 'W'));

# 27

$objHaw->change(level => 3);

ok($objHaw->lt('a', 'A'));
ok($objHaw->lt('e', 'E'));
ok($objHaw->lt('i', 'I'));
ok($objHaw->lt('o', 'O'));
ok($objHaw->lt('u', 'U'));
ok($objHaw->lt('h', 'H'));
ok($objHaw->lt('k', 'K'));
ok($objHaw->lt('l', 'L'));
ok($objHaw->lt('m', 'M'));
ok($objHaw->lt('n', 'N'));
ok($objHaw->lt('p', 'P'));
ok($objHaw->lt('w', 'W'));

# 39

ok($objHaw->eq("a\x{304}", "\x{101}"));
ok($objHaw->eq("A\x{304}", "\x{100}"));
ok($objHaw->eq("e\x{304}", "\x{113}"));
ok($objHaw->eq("E\x{304}", "\x{112}"));
ok($objHaw->eq("i\x{304}", "\x{12B}"));
ok($objHaw->eq("I\x{304}", "\x{12A}"));
ok($objHaw->eq("o\x{304}", "\x{14D}"));
ok($objHaw->eq("O\x{304}", "\x{14C}"));
ok($objHaw->eq("u\x{304}", "\x{16B}"));
ok($objHaw->eq("U\x{304}", "\x{16A}"));

# 49
