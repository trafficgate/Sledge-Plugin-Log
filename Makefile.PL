use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Sledge::Plugin::Log',
    'VERSION_FROM' => 'lib/Sledge/Plugin/Log.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
    },
);
