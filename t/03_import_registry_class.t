use strict;
use warnings;
use lib '.';

use t::helper;
use Test::More;

use Text::Xslate;


{
    package t::My::Registry;
    use Type::Registry;
    use Type::Utils qw(class_type enum);

    my $reg = Type::Registry->for_me;
    $reg->add_type(enum('Beef', 'Pork', 'Chicken'), 'Meat');
    $reg->add_type(class_type('t::SomeModel'), 'My::Registry::SomeModel');
}


done_testing;
