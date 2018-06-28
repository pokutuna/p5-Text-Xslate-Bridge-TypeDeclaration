use strict;
use warnings;
use lib '.';

use t::helper;
use Test::More;

use Text::Xslate;

my $xslate = Text::Xslate->new(
    path         => path,
    cache_dir    => cache_dir,
    module       => [ 'Text::Xslate::Bridge::TypeDeclaration' ],
    warn_handler => sub {}, # supress error to stderr
);

is $xslate->render('one.tx', { name => 'cocoa', age => 15 }), "cocoa(15)\n";

cmp_error_body $xslate->render('one.tx', { name => 'chino', age => 'tippy' }), <<EOS;
Declaration mismatch for `age`
  Value "tippy" did not pass type constraint "Int"
EOS


is $xslate->render('two.tx', { i => 123, h => { s => 'hoge' }}),
    "i:123, h.s:hoge\n";

is $xslate->render('two.tx', { h => { s => 'hoge' } }),
    "i:, h.s:hoge\n";

is $xslate->render('two.tx', { h => { s => undef } }),
    "i:, h.s:\n";

cmp_error_body $xslate->render('two.tx', {}), <<EOS;
Declaration mismatch for `h`
  Undef did not pass type constraint "Dict[s=>Maybe[Str],slurpy Any]"
EOS


is $xslate->render('optional.tx', { profile => { name => 'pokutuna', age => 30 } }), <<EOS;
pokutuna(30)
EOS

is $xslate->render('optional.tx', { profile => { name => 'oneetyan' } }), <<EOS;
oneetyan(unknown)
EOS

cmp_error_body $xslate->render('optional.tx', { profile => { name => 'oneetyan', age => undef } }), <<EOS;
Declaration mismatch for `profile`
  Reference {"age" => undef,"name" => "oneetyan"} did not pass type constraint "Dict[age=>Optional[Int],name=>Str,slurpy Any]"
EOS

# https://metacpan.org/pod/Types::Standard#Optional[%60a]
# > Note that any use of Optional[`a] outside the context of parameterized Dict and Tuple type constraints makes little sense, and its behaviour is undefined.
cmp_error_body $xslate->render('bare_optional.tx', { name => 'oneetyan' }), <<EOS;
Declaration mismatch for `age`
  Undef did not pass type constraint "Optional[Int]"
EOS


cmp_error_body $xslate->render('structured_type_not_found.tx', { foo => { bar => 1 }}), <<EOS;
Declaration mismatch for `foo`
  Reference {"bar" => 1} did not pass type constraint "Dict[bar=>"SomeCollection[Any]",slurpy Any]"
EOS

done_testing;

__DATA__
@@ one.tx
<: declare(name => 'Str', age => 'Int') -:>
<: $name :>(<: $age :>)
@@ two.tx
<: declare(i => 'Maybe[Int]', h => { s => 'Maybe[Str]' }) -:>
i:<: $i :>, h.s:<: $h.s :>
@@ optional.tx
<: declare(profile => { name => 'Str', age => 'Optional[Int]' }) -:>
<: $profile.name :>(<: $profile.age ? $profile.age : 'unknown' :>)
@@ bare_optional.tx
<: declare(name => 'Str', age => 'Optional[Int]') -:>
<: $name :>(<: $age ? $age : 'unknown' :>)
@@ structured_type_not_found.tx
<: declare(foo => { bar => 'SomeCollection[Any]' }) -:>
foo.bar:<: $foo.bar :>
