# $Id$
package Pod::TOC;
use strict;

use base qw( Pod::Simple );

use subs qw();
use vars qw( $VERSION );

$VERSION = '1.07';

sub _handle_element
	{
	my( $self, $element, $args ) = @_;
	
	my $caller_sub = ( caller(1) )[3];
	return unless $caller_sub =~ s/.*_(start|end)$/_${1}_$element/;
	
	my $sub = $self->can( $caller_sub );

	$sub->( $self, $args ) if $sub;
	}

sub _handle_element_start  
	{ 
	my $self = shift;
	$self->_handle_element( @_ ); 
	}
	
sub _handle_element_end    
	{ 
	my $self = shift;
	$self->_handle_element( @_ ); 
	}

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
		my $name = "_${prepend}_$directive";
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
	
	my $on  = $caller =~ m/^_start_/ ? 1 : 0;
	my $off = $caller =~ m/^_end_/   ? 1 : 0;
	
	unless( $on or $off ) { return };
	
	my( $tag ) = $caller =~ m/^_.*?_(.*)/g;
	
	return unless $self->_is_valid_tag( $tag );
	
	$Flag = do {
		   if( $on  ) { $self->_get_tag( $tag ) } # set the flag if we're on
		elsif( $off ) { undef }                   # clear if we're off
		};

	}
}

=head1 NAME

Pod::TOC - Extract a table of contents from a Pod file

=head1 SYNOPSIS

This is a C<Pod::Simple> subclass, so it can do the same things.

	use Pod::TOC;

	my $parser = Pod::TOC->new;
	
	my $toc;
	open my($output_fh), ">", \$toc;
	
	$parser->output_fh( $output_fh );
	
	$parser->parse_file( $input_file );
	
=head1 DESCRIPTION

This is a C<Pod::Simple> subclass to extract a table of contents
from a pod file. It has the same interface as C<Pod::Simple>, and
only changes the internal bits.

=head1 SEE ALSO

L<Pod::Perldoc::ToToc>, L<Pod::Simple>

=head1 SOURCE AVAILABILITY

This source is part of a Google Code project which always has the
latest sources in SVN.

	http://code.google.com/p/brian-d-foy/source

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2006-2007 brian d foy.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
