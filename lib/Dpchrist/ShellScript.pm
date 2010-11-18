#######################################################################
# $Id: ShellScript.pm,v 1.7 2010-11-18 07:28:11 dpchrist Exp $
#######################################################################
# package/ uses/ requires:
#----------------------------------------------------------------------

package Dpchrist::ShellScript;

use 5.010000;
use strict;
use warnings;

require Exporter;

use Dpchrist::Debug	qw( :all );
use Dpchrist::Module;
use Env::PS1;

#######################################################################
# package variables:
#----------------------------------------------------------------------

use constant                    DEBUG => 0;

our @ISA = qw(Exporter);

our @EXPORT = ();

our %EXPORT_TAGS = ( 'all' => [ qw(
    ps1_system
) ] );

our @EXPORT_OK = (
    @{ $EXPORT_TAGS{'all'} },
);

our $VERSION = sprintf "%d.%03d", q$Revision: 1.7 $ =~ /: (\d+)\.(\d+)/;

use Carp	qw( confess );

#######################################################################

=head1 NAME

Dpchrist::ShellScript - utility functions for shell scripts


=head1 DESCRIPTION

=head2 SUBROUTINES

=cut


#######################################################################

=head3 ps1_system

    ps1_system LIST

Prints '$ ',
LIST items seperated by spaces,
and newline to STDOUT,
and then returns by calling 'system LIST'.

=cut

#----------------------------------------------------------------------

sub ps1_system
{
    ddump('entry', [\@_], [qw(*_)]) if DEBUG;

    ddump([\%ENV], [qw(ENV)]) if DEBUG;

#    $ENV{PS1} ||= $0 . '$ ';

#    my $format = $ENV{PS1};
#    ddump([$format], [qw(format)]) if DEBUG;

#    my $ps1 = Env::PS1::sprintf( $format );
#    ddump([$ps1], [qw(ps1)]) if DEBUG;

    print
#	  $ps1,
	'$ ',
      	join(' ', @_),
	"\n";
    
    return system @_;
}

#######################################################################
# end of code:
#----------------------------------------------------------------------

1;
__END__

#######################################################################

=head2 EXPORT

None by default.

All of the subroutines may be imported by using the ':all' tag:

    use Dpchrist::ShellScript		qw( :all );

See 'perldoc Export' for everything in between.


=head1 INSTALLATION

    perl Makefile.PL
    make
    make test
    make install


=head1 DEPENDENCIES

    Dpchrist::Module


=head1 AUTHOR

David Paul Christensen  dpchrist@holgerdanske.com


=head1 COPYRIGHT AND LICENSE

Copyright 2010 by David Paul Christensen dpchrist@holgerdanske.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; version 2.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
USA.

=cut

#######################################################################
