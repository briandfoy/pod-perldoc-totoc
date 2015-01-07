require 5.008;
use strict;
use warnings;


# Stupid Mac extended attribute files
unlink glob ( map { "$_/._*" } ( '', qw(t lib examples) ) );

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/Pod/Perldoc/ToToc.pm';

my %WriteMakefile = (
	'NAME'          => 'Pod::Perldoc::ToToc',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	'PREREQ_PM'    => {
		'ExtUtils::MakeMaker' => '6.46',
		'Test::More'          => '0.95',
		'Pod::Perldoc'        => '0',
		'Pod::Simple'         => '0',
		'parent'              => '0',
		},

	'META_MERGE' => {
		resources => {
			repository => 'https://github.com/briandfoy/pod-perldoc-totoc',
			},
		},

	clean  => { FILES    => q|Pod-Perldoc-ToToc-*| },
	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version" || die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
