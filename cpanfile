requires 'Exporter';
requires 'Carp';
requires 'Scalar::Util';
requires 'Params::Validate';
requires 'Tree::Simple';
requires 'perl', '5.010';

on 'build', sub {
    requires 'Module::Build', '0.4234';
};

on 'test', sub {
    requires 'Data::Dumper';
    requires 'Data::FormValidator';
    requires 'Env';
    requires 'English';
    requires 'File::Spec';
    requires 'Pod::Coverage::TrustPod';
    requires 'Test::Class';
    requires 'Test::CPAN::Changes';
    requires 'Test::Exception';
    requires 'Test::Kwalitee', '1.28';
    requires 'Test::More', '1.302213';
    requires 'Test::Pod', '1.52';
    requires 'Test::Pod::Coverage', '1.10';
    requires 'Test::Taint';
    requires 'Test::Tester', '1.302214';
};

on 'configure', sub {
    requires 'ExtUtils::MakeMaker';
    requires 'Module::Build', '0.4234';
};

on 'develop', sub {
    requires 'Pod::Coverage::TrustPod';
    requires 'Test::CPAN::Changes', '0.500005';
    requires 'Test::CPAN::Meta::JSON', '0.16';
    requires 'Test::Kwalitee', '1.28';
    requires 'Test::Perl::Critic';
    requires 'Test::Pod', '1.52';
    requires 'Test::Pod::Coverage', '1.10';
};
