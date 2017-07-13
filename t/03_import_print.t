use strict;
use warnings;
use lib '.';

use t::helper;
use Test::More;

use Text::Xslate;

subtest 'html' => sub {
    my $xslate = Text::Xslate->new(
        type         => 'html',
        path         => path,
        cache_dir    => cache_dir,
        warn_handler => sub {},

        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                print => 1,
            ],
        ],
    );

    my $res = $xslate->render('a.tx', { a => "hoge" });
    is $res, <<EOS;
<pre class="type-declaration-mismatch">
Declaration mismatch for `a`
  declaration: &#39;Int&#39;
        value: &#39;hoge&#39;
</pre>
hoge
EOS
};

subtest 'text' => sub {
    my $xslate = Text::Xslate->new(
        type         => 'text' ,
        path         => path,
        cache_dir    => cache_dir,
        warn_handler => sub {},

        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                print => 1,
            ],
        ],
    );

    my $res = $xslate->render('a.tx', { a => "hoge" });
    is $res, <<EOS;
Declaration mismatch for `a`
  declaration: 'Int'
        value: 'hoge'
hoge
EOS
};

subtest 'none' => sub {
    my $died = 0;

    my $xslate = Text::Xslate->new(
        type         => 'html' ,
        path         => path,
        cache_dir    => cache_dir,
        die_handler => sub { $died += 1},

        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                print => 0,
            ],
        ],
    );

    my $res = $xslate->render('a.tx', { a => "hoge" });
    is $res, "hoge\n";
    is $died, 1;
};

done_testing;

__DATA__
@@ a.tx
<: declare(a => 'Int'):><: $a :>
