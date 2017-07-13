[![Build Status](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration.svg?branch=master)](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration) [![Coverage Status](https://img.shields.io/coveralls/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration/master.svg?style=flat)](https://coveralls.io/r/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration?branch=master)
# NAME

Text::Xslate::Bridge::TypeDeclaration - A Type::Tiny based Type Validator in Xslate.

# SYNOPSIS

    my $xslate = Text::Xslate->new(
        module => [ 'Text::Xslate::Bridge::TypeDeclaration' ],
    );

    # @@ template.tx
    # <:- declare(drink => 'Enum["Cocoa", "Cappuchino", "Tea"]') -:>
    # May I have a cup of <: $drink :>.

    # Success!
    $xslate->render('template.tx', { drink => 'Cocoa' });
    # Output:
    #   May I have a cup of Cocoa.


    # A string 'Oil' is not a drink
    is $xslate->render('template.tx', { drink => 'Oil' });
    # Output:
    #   <pre class="type-declaration-mismatch">
    #   Declaration mismatch for `drink`
    #     Value "Oil" did not pass type constraint "Enum["Cocoa", "Cappuchino", "Tea"]"
    #   </pre>
    #   May I have a cup of Oil.

# DESCRIPTION

Text::Xslate::Bridge::TypeDeclaration is a type validator module in [Text::Xslate](https://metacpan.org/pod/Text::Xslate) templates.

The type validation of this module is base on [Type::Tiny](https://metacpan.org/pod/Type::Tiny).

[Type::Tiny](https://metacpan.org/pod/Type::Tiny) type constraints are compatible with Moo, Moose and Mouse.

`declare` interface was implemented with reference to [Smart::Args](https://metacpan.org/pod/Smart::Args).

# DECLARATIONS

## Types::Standard

See [Types::Standard](https://metacpan.org/pod/Types::Standard).

These are imported by default [Text::Xslate::Bridge::TypeDeclaration::Registry](https://metacpan.org/pod/Text::Xslate::Bridge::TypeDeclaration::Registry).

You can not use them unless you import [Types::Standard](https://metacpan.org/pod/Types::Standard) with specifying registry by `registry_class` option.

- `declare(name => 'Str')`
- `declare(user_ids => 'ArrayRef[Int]')`
- `declare(person_hash => 'Dict[name => Str, age => Int]')`

## Class-Type

These are defined by default [Text::Xslate::Bridge::TypeDeclaration::Registry](https://metacpan.org/pod/Text::Xslate::Bridge::TypeDeclaration::Registry) when a name is not found in registry.

- `declare(engine => 'Text::Xslate')`
- `declare(visitor => 'Maybe[My::Model::UserAccount]')`

## Hashref

Hashref is treated as `Dict[... slurpy Any]`.

This is a ** slurpy ** match. Less value is error. Extra values are ignored.

- `declare(account_summary => { name => 'Str', subscriber_count => 'Int', icon => 'My::Image' })`
- `declare(sidebar => { profile => { name => 'Str', followers => 'Int' }, recent_entries => 'ArrayRef[My::Entry]' })`

# OPTIONS

    Text::Xslate->new(
        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                # defaults
                method         => 'declare', # method name to export
                validate       => 1,         # enable validation when truthy
                print          => 1,         # enable printing errors to the output buffer when truthy
                on_mismatch    => 'die',     # error handler ('die', 'warn' or 'none')
                registry_class => undef,     # package name for specifying Type::Registry
            ]
        ]
    );

# APPENDIX

## Disable Validation on Production

Perhaps you want to disable validation in production to prevent spoiling performance on a [Plack](https://metacpan.org/pod/Plack) application.

    Text::Xslate->new(
        module => [
            'Text::Xslate::Bridge::TypeDeclaration' => [
                validate => $ENV{PLACK_ENV} ne 'production',
            ],
        ],
    );

## Use `type-declaration-mismatch` class name

Highlight by css

    .type-declaration-mismatch { color: crimson; }

Lint with [Test::WWW::Mechanize](https://metacpan.org/pod/Test::WWW::Mechanize)

    # in subclass of Test::WWW::Mechanize
    sub _lint_content_ok {
        my ($self, $desc) = @_;

        if (my $mismatch = $self->scrape_text_by_attr('class', 'type-declaration-mismatch')) {
            $Test::Builder::Test->ok(0, $mismatch);
        };

        return $self->SUPER::_lint_content_ok($desc);
    }

# SEE ALSO

[Text::Xslate](https://metacpan.org/pod/Text::Xslate), [Text::Xslate::Bridge](https://metacpan.org/pod/Text::Xslate::Bridge)

[Type::Tiny](https://metacpan.org/pod/Type::Tiny), [Types::Standard](https://metacpan.org/pod/Types::Standard), [Type::Registry](https://metacpan.org/pod/Type::Registry)

[Smart::Args](https://metacpan.org/pod/Smart::Args), [Test::WWW::Mechanize](https://metacpan.org/pod/Test::WWW::Mechanize)

# LICENSE

Copyright (C) pokutuna.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

pokutuna <popopopopokutuna@gmail.com>
