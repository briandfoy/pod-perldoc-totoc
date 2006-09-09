# $Id$

use Test::More 'no_plan';

use File::Spec;

my $file = File::Spec->catfile( 't', 'example.pod' );
ok( -e $file, "Test file exists" );

use_ok( 'Pod::TOC' );

my $output = '';
open my( $fh ), ">", \$output;

my $parser = Pod::TOC->new();
isa_ok( $parser, 'Pod::TOC' );

$parser->output_fh( $fh );
$parser->parse_file( $file );

my $expected = <<"HERE";
Chapter title
Section 1
	Section 1 Subsection 1
	Section 1 Subsection 2
	Section 1 Subsection 3
		Section 1 Subsection 3 Subsubsection 1
		Section 1 Subsection 3 Subsubsection 2
Section 2
Section 3
HERE

is( $output, $expected, "TOC comes out right" );
