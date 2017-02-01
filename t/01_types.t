use strict;
use warnings;
use t::helper;

use Test::More;

use Text::Xslate::Bridge::TypeDeclaration;

*_type = \&Text::Xslate::Bridge::TypeDeclaration::_type;
*_hash_structure = \&Text::Xslate::Bridge::TypeDeclaration::_hash_structure;
*_array_structure = \&Text::Xslate::Bridge::TypeDeclaration::_array_structure;

sub validate {
    my ($structure, $data) = @_;
    return _type($structure)->check($data);
}

subtest 'Other Ref' => sub {
    ok !validate(\'Int', 1);
    ok !validate('Int', \1);
    ok !validate(\{ a => 'Str' }, { a => 'hoge' });
    ok !validate({ a => 'Str' }, \{ a => 'hoge' });
};

subtest 'undef' => sub {
    ok  validate('Undef', undef);
    ok !validate(undef, undef);
};

done_testing;
