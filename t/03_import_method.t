use strict;
use warnings;
use lib '.';

use t::helper;
use Test::More;

use Text::Xslate;

my $xslate = Text::Xslate->new(
    path         => path,
    cache_dir    => cache_dir,
    warn_handler => sub {},
    module => [
        'Text::Xslate::Bridge::TypeDeclaration' => [ method => 'type' ]
    ],
);

{
    local $@;
    my $res = eval { $xslate->render('one.tx', { num => 123 }) };
    like $@, qr/\AText::Xslate: Undefined symbol 'declare'/;
    is $res, undef;
}

{
    local $@;
    my $res = eval { $xslate->render('two.tx', { num => 123 }) };
    is $@, '';
    is $res, "123\n";
}

{
    local $@;
    my $res = eval { $xslate->render('two.tx', { num => 'hoge' }) };
    is $@, '';
    cmp_error_body $res, <<EOS;
Declaration mismatch for `num`
  Value "hoge" did not pass type constraint "Int"
EOS
}

done_testing;

__DATA__
@@ one.tx
<: declare(num => 'Int') :><: $num :>
@@ two.tx
<: type(num => 'Int') :><: $num :>
