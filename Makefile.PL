use ExtUtils::MakeMaker;

require 5.008;

eval "use Test::Manifest 1.21";

# Stupid Mac extended attribute files
unlink glob ( map { "$_/._*" } ( '', qw(t lib examples) ) );

WriteMakefile(
	'NAME'          => 'Pod::Perldoc::ToToc',
	'VERSION_FROM'  => 'lib/Pod/Perldoc/ToToc.pm',
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',
	'ABSTRACT'      => 'Turn one or more Pod files into a table of contents',

	'PREREQ_PM'    => {
		'Test::More'   => '0.95',
		'Pod::Perldoc' => '0',
		'Pod::Simple'  => '0',
		},

	clean  => { FILES    => q|Pod-Perldoc-ToToc-*| },
	);
