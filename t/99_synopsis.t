use strict;
use warnings;
use lib '.';
use t::helper;

use Test::More;
use Text::Xslate;

{
    package Some::Model::User;
    sub new  { my $class = shift; bless +{ @_ }, $class }
    sub name { $_[0]->{name} }
}


my $xslate = Text::Xslate->new(
    path         => path,
    cache_dir    => cache_dir,
    warn_handler => sub {},
    module => [
        'Text::Xslate::Bridge::TypeDeclaration',
    ],
);

is $xslate->render('template.tx', +{
    user  => Some::Model::User->new(name => 'pokutuna'),
    drink => 'Cocoa',
}), <<EOS;
pokutuna is drinking a cup of Cocoa.
EOS

cmp_error_body $xslate->render('template.tx', +{
    user  => Some::Model::User->new(name => 'pokutuna'),
    drink => 'Oil',
}), <<EOS;
Declaration mismatch for `drink`
  Value "Oil" did not pass type constraint "Enum["Cocoa","Cappuchino","Tea"]"
EOS

done_testing;

__DATA__
@@ template.tx
<:- declare(
  user  => 'Some::Model::User',
  drink => 'Enum["Cocoa", "Cappuchino", "Tea"]'
) -:>
<: $user.name :> is drinking a cup of <: $drink :>.
