requires 'perl', '5.008001';

requires 'Carp';
requires 'Data::Dumper';
requires 'List::Util';
requires 'Text::Xslate';
requires 'Text::Xslate::Bridge';
requires 'Type::Tiny';
requires 'Type::Tiny::XS';

on 'test' => sub {
    requires 'Data::Section::Simple';
    requires 'File::Temp';
    requires 'Mouse::Util::TypeConstraints';
    requires 'MouseX::Types';
    requires 'Test::Fatal';
    requires 'Test::More', '0.98';
    requires 'Test::Name::FromLine';
};
