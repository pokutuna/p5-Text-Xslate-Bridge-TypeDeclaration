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

is $xslate->render('one.tx', { name => 'chino', age => 'tippy' }), <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `age`
  Value &quot;tippy&quot; did not pass type constraint &quot;Int&quot;
</pre>
chino(tippy)
EOS

is $xslate->render('two.tx', { i => 123, h => { s => 'hoge' }}),
    "i:123, h.s:hoge\n";

is $xslate->render('two.tx', { h => { s => 'hoge' } }),
    "i:, h.s:hoge\n";

is $xslate->render('two.tx', { h => { s => undef } }),
    "i:, h.s:\n";

is $xslate->render('two.tx', {}), <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `h`
  Undef did not pass type constraint &quot;Dict[s=&gt;Maybe[Str],slurpy Any]&quot;
</pre>
i:, h.s:
EOS

is $xslate->render('optional.tx', { profile => { name => 'pokutuna', age => 30 } }), <<EOS;
pokutuna(30)
EOS

is $xslate->render('optional.tx', { profile => { name => 'oneetyan' } }), <<EOS;
oneetyan(unknown)
EOS

is $xslate->render('optional.tx', { profile => { name => 'oneetyan', age => undef } }), <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `profile`
  Reference {&quot;age&quot; =&gt; undef,&quot;name&quot; =&gt; &quot;oneetyan&quot;} did not pass type constraint &quot;Dict[age=&gt;Optional[Int],name=&gt;Str,slurpy Any]&quot;
</pre>
oneetyan(unknown)
EOS

is $xslate->render('structured_type_not_found.tx', { foo => { bar => 1 }}), <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `foo`
  Reference {&quot;bar&quot; =&gt; 1} did not pass type constraint &quot;Dict[bar=&gt;&quot;SomeCollection[Any]&quot;,slurpy Any]&quot;
</pre>
foo.bar:1
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
@@ structured_type_not_found.tx
<: declare(foo => { bar => 'SomeCollection[Any]' }) -:>
foo.bar:<: $foo.bar :>
