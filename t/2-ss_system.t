# $Id: 2-ss_system.t,v 1.3 2010-03-28 18:47:55 dpchrist Exp $

use strict;
use warnings;

use Dpchrist::ShellScript qw( ss_system );
use Test::More tests => 2;

use Capture::Tiny	qw( capture );
use Carp		qw( confess );
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
	ss_system $line;
    };
};
ok(								#     1
    $r
    && $stdout =~ /${ps1}$line.*hello. world/s
    && $stderr eq ''
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr, $@],
		     [qw(line   r   stdout   stderr   @)])
);

$line = "/nosuchcommand";
($stdout, $stderr) = capture { $r = eval { ss_system $line }; };
ok(								#     2
    !defined $r
    && $stdout eq "${ps1}$line\n"
    && $stderr =~ /Can't exec "$line": No such file or directory/
) or confess join(' ', __FILE__, __LINE__,
    Data::Dumper->Dump([$line, $r, $stdout, $stderr],
		     [qw(line   r   stdout   stderr)])
);

