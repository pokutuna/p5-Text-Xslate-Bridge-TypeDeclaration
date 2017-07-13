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
        'Text::Xslate::Bridge::TypeDeclaration',
    ],
);

like $xslate->render('template.tx', { drink => 'Cocoa' }),
    qr/May I have a cup of Cocoa\./;

is $xslate->render('template.tx', { drink => 'Oil' }), <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `drink`
  Value &quot;Oil&quot; did not pass type constraint &quot;Enum[&quot;Cocoa&quot;,&quot;Cappuchino&quot;,&quot;Tea&quot;]&quot;
</pre>
May I have a cup of Oil.
EOS

done_testing;

__DATA__
@@ template.tx
<:- declare(drink => "Enum['Cocoa', 'Cappuchino', 'Tea']") -:>
May I have a cup of <: $drink :>.
