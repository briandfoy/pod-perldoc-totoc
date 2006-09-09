# $Id$
package Pod::TOC;
use strict;

use base qw( Pod::Simple );

use subs qw();
use vars qw( $VERSION );

$VERSION = '0.10_01';

sub _handle_element
	{
	my( $self, $element, $args ) = @_;
	
	my $caller_sub = ( caller(1) )[3];
	return unless $caller_sub =~ s/.*_(start|end)$/${1}_$element/;
	
	my $sub = $self->can( $caller_sub );

	$sub->( $self, $args ) if $sub;
	}

sub _handle_element_start  { &_handle_element }
sub _handle_element_end    { &_handle_element }

sub _handle_text 
	{	
	return unless $_[0]->_get_flag;
	
	print { $_[0]->output_fh } 
		"\t" x ( $_[0]->_get_flag - 1 ), $_[1], "\n";
	}


{
my @Head_levels = 0 .. 4;

my %flags = map { ( "head$_", $_ ) } @Head_levels;

foreach my $directive ( keys %flags )
	{
	no strict 'refs';	
	foreach my $prepend ( qw( start end ) )
		{
		my $name = "${prepend}_$directive";
		*{$name} = sub { $_[0]->_set_flag( $name ) };
		}
	}

sub _is_valid_tag { exists $flags{ $_[1] } }
sub _get_tag      {        $flags{ $_[1] } }
}

{
my $Flag;

sub _get_flag { $Flag }

sub _set_flag 
    {
	my( $self, $caller ) = @_;
		
	return unless $caller;
	
	my $on  = $caller =~ m/^start_/ ? 1 : 0;
	my $off = $caller =~ m/^end_/   ? 1 : 0;
	
	unless( $on or $off ) { return };
	
	my( $tag ) = $caller =~ m/_(.*)/g;
	
	return unless $self->_is_valid_tag( $tag );
	
	$Flag = do {
		   if( $on  ) { $self->_get_tag( $tag ) } # set the flag if we're on
		elsif( $off ) { undef }                  # clear if we're off
		};

	}
}

=head1 NAME

Pod::TOC - Extract a Table of Contents from a pod file

=head1 SYNOPSIS

	use Pod::TOC;

=head1 DESCRIPTION


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

Copyright (c) 2004, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

1;
