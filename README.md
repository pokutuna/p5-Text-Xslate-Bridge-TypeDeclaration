[![Build Status](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration.svg?branch=master)](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration) [![Coverage Status](https://img.shields.io/coveralls/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration/master.svg?style=flat)](https://coveralls.io/r/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration?branch=master)
# NAME

Text::Xslate::Bridge::TypeDeclaration - A Mouse-based Type Validator in Xslate.

# SYNOPSIS

    my $xslate = Text::Xslate->new(
        module => [ 'Text::Xslate::Bridge::TypeDeclaration' ],
    );

    # @@ template.tx
    # <:- declare(name => 'Str', engine => 'Text::Xslate') -:>
    # <: $name :> version is <: $engine.VERSION :>.

    # Success!
    $xslate->render('template.tx', {
        name   => 'Text::Xslate',
        engine => $xslate
    });
    # Text::Xslate version is 3.4.0.


    # A string 'TT' is not isa 'Text::Xslate'
    $xslate->render('template.tx', {
        name   => 'Text::Xslate',
        engine => $xslate
    });
    # <pre class="type-declaration-mismatch">
    # Declaration mismatch for `engine`
    #   declaration: 'Text::Xslate'
    #         value: 'TT'
    # </pre>
    # Template::Toolkit version is .

# DESCRIPTION

Text::Xslate::Bridge::TypeDeclaration is a type validator module in [Text::Xslate](https://metacpan.org/pod/Text::Xslate) templates.
The type validation of this module is base on [Mouse::Util::TypeConstraints](https://metacpan.org/pod/Mouse::Util::TypeConstraints).
`declare` interface was implemented with reference to [Smart::Args](https://metacpan.org/pod/Smart::Args).

# DECLARATIONS

## Mouse Defaults

\- These are provided by [Mouse::Util::TypeConstraints](https://metacpan.org/pod/Mouse::Util::TypeConstraints).
\- `declare(name => 'Str')`
\- `declare(user_ids => 'ArrayRef[Int]')`

## Object

\- These are defined by `find_or_create_isa_type_constraint` when declared.
\- `declare(engine => 'Text::Xslate')`
\- `declare(visitor => 'Maybe[My::Model::UserAccount]')`

## Hashref

## Arrayref

# OPTIONS

    Text::Xslate->new(
        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                # defaults
                method      => 'declare', # method name to export
                validate    => 1,         # enable validation when truthy
                print       => 'html',    # error output format ('html', 'text' or 'none')
                on_mismatch => 'die',     # error handler ('die', 'warn' or 'none')
            ]
        ]
    );

# SEE ALSO

[Mouse::Util::TypeConstraints](https://metacpan.org/pod/Mouse::Util::TypeConstraints)
[Smart::Args](https://metacpan.org/pod/Smart::Args)
[Text::Xslate](https://metacpan.org/pod/Text::Xslate)

# LICENSE

Copyright (C) pokutuna.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

pokutuna <popopopopokutuna@gmail.com>
