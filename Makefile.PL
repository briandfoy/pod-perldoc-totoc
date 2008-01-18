# $Id: Makefile.PL,v 1.4 2004/07/04 17:04:17 comdog Exp $
use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.14";

# Stupid Mac extended attribute files
unlink glob ( map { "$_/._*" } ( '', qw(t lib examples) ) );

WriteMakefile(
	'NAME'          => 'Pod::Perldoc::ToToc',
	'VERSION_FROM'  => 'lib/ToToc.pm',
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	'ABSTRACT'      => 'Turn one or more Pod files into a table of contents',

	'PREREQ_PM'    => {
		'Test::More'   => '0',
		'Pod::Perldoc' => '0',
		'Pod::Simple'  => '0',
		},

	'PM'           => {
		'lib/ToToc.pm'         => '$(INST_LIBDIR)/ToToc.pm',
		'lib/TOC.pm'           => 'blib/lib/Pod/TOC.pm',
		},

	'MAN3PODS'     => {
		'lib/ToToc.pm' => '$(INST_MAN3DIR)/Pod::Perldoc::ToToc.3',
		'lib/TOC.pm'   => '$(INST_MAN3DIR)/Pod::TOC.3',
		},

	clean  => { FILES    => q|Pod-Perldoc-ToToc-*| },
	);
