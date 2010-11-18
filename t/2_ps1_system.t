# $Id: 2_ps1_system.t,v 1.5 2010-11-18 07:28:11 dpchrist Exp $

use strict;
use warnings;

use Dpchrist::ShellScript qw( ps1_system );
use Test::More tests => 2;

use Capture::Tiny	qw( capture );
use Carp;
use Data::Dumper;
use Dpchrist::Debug	qw( :all );

$Data::Dumper::Sortkeys = 1;
my $ps1 = $ENV{PS1} = __FILE__ . __LINE__ . ' ';

my $line;
my $r;
my $stderr;
my $stdout;


$line = "echo 'hello, world!'";
($stdout, $stderr) = capture {
    $r = eval { 
	ps1_system $line;
    };
};
ok(								#     1
    !$@
    && $r == 0
    && $stdout =~ /$line\nhello\, world\!\n$/
    && $stderr eq ''
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr, $@],
		     [qw(line   r   stdout   stderr   @)])
);

$line = "/nosuchcommand";
($stdout, $stderr) = capture {
    $r = eval {
	ps1_system $line;
    };
};
ok(								#     2
    !$@
    && $r
    && $stdout =~ /$line\n$/
    && $stderr =~ /Can't exec "$line": No such file or directory/
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr],
		     [qw(line   r   stdout   stderr)])
);

