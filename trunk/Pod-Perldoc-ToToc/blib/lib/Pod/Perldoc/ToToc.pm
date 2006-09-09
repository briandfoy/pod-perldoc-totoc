# $Id$
package Pod::Perldoc::ToToc;
use strict;

use base qw(Pod::Perldoc::BaseTo);

use subs qw();
use vars qw( $VERSION );

use Pod::TOC;

$VERSION = '0.10_01';

sub is_pageable        { 1 }
sub write_with_binmode { 0 }
sub output_extension   { 'toc' }

sub parse_from_file 
	{
	my( $self, $file, $output_fh ) = @_; # Pod::Perldoc object
	
	print STDERR "Output filehandle is $output_fh\n";
	my $parser = Pod::TOC->new();

	$parser->output_fh( $output_fh );
		
	$parser->parse_file( $file );
	}
	
=head1 NAME

Pod::Perldoc::ToToc - This is the description

=head1 SYNOPSIS

	use Pod::Perldoc::ToToc;

=head1 DESCRIPTION

=cut



=head1 TO DO


=head1 SEE ALSO


=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	http://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT

Copyright (c) 2006, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

1;
