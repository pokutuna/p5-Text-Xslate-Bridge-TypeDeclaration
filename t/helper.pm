package t::helper;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT = qw(cmp_error_body cache_dir path);

use Data::Section::Simple;
use File::Temp qw(tempdir);
use HTML::Entities qw(decode_entities);
use Test::Builder;
use Test::More;
use Test::Name::FromLine;

sub cmp_error_body($$;$) {
    my ($got, $expect, $message) = @_;

    $got =~ qr|<pre class="type-declaration-mismatch">\n(.+)</pre>|sm;

    local $Testn::Builder::Level = $Test::Builder::Level + 1;
    is(decode_entities($1), $expect, $message);
}

sub cache_dir {
    tempdir('.xslate_cache_XXXX', CLEANUP => 1);
}

sub path {
    my $caller = caller;
    [ Data::Section::Simple->new($caller)->get_data_section ];
}

{
    package t::SomeModel;
    sub new { bless +{}, $_[0] };
}

{
    package t::OneModel;
    sub new { bless +{}, $_[0] };
}

{
    package t::AnotherModel;
    sub new { bless +{}, $_[0] };
}

1;
