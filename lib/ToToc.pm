 # $Id$
package Pod::Perldoc::ToToc;
use strict;

use base qw(Pod::Perldoc::BaseTo);

use subs qw();
use vars qw( $VERSION );

use Pod::TOC;

$VERSION = '1.07';

sub is_pageable        { 1 }
sub write_with_binmode { 0 }
sub output_extension   { 'toc' }

sub parse_from_file 
	{
	my( $self, $file, $output_fh ) = @_; # Pod::Perldoc object
	
	my $parser = Pod::TOC->new();

	$parser->output_fh( $output_fh );
		
	$parser->parse_file( $file );
	}
	
=head1 NAME

Pod::Perldoc::ToToc - Translate Pod to a Table of Contents

=head1 SYNOPSIS

Use this module with C<perldoc>'s C<-M> switch.

	% perldoc -MPod::Perldoc::ToToc Module::Name

=head1 DESCRIPTION

This module uses the C<Pod::Perldoc> module to extract a table of 
contents from a pod file.

=head1 METHODS

=over 4

=item parse_from_file( FILENAME, OUTPUT_FH )

Parse the file named in C<FILENAME> using C<Pod::TOC> and send the
results to the output filehandle C<OUTPUT_FH>.

=back

=head1 SEE ALSO

L<Pod::Perldoc>

=head1 SOURCE AVAILABILITY

This source is part of a Google Code project which always has the
latest sources in SVN.

	http://code.google.com/p/brian-d-foy/source

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2006-2007, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

1;