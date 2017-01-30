package t::helper;
use strict;
use warnings;

use Test::Name::FromLine;

{
    package t::SomeModel;
    sub new { bless +{}, $_[0] };
}
{
    package t::AnyModel;
    sub new { bless +{}, $_[0] };
}


1;
