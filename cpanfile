requires 'perl', '5.008001';

requires 'Carp';
requires 'Data::Printer';
requires 'List::Util';
requires 'Mouse::Util::TypeConstraints';
requires 'Text::Xslate';
requires 'Text::Xslate::Bridge';

on 'test' => sub {
    requires 'Test::Fatal';
    requires 'Test::More', '0.98';
    requires 'Test::Name::FromLine';
};
