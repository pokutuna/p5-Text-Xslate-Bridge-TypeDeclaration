[![Build Status](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration.svg?branch=master)](https://travis-ci.org/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration) [![Coverage Status](https://img.shields.io/coveralls/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration/master.svg?style=flat)](https://coveralls.io/r/pokutuna/p5-Text-Xslate-Bridge-TypeDeclaration?branch=master)
# NAME

Text::Xslate::Bridge::TypeDeclaration - It's new $module

# SYNOPSIS

    use Text::Xslate::Bridge::TypeDeclaration;

Text::Xslate->new(
    module => \[
        'Text::Xslate::Bridge::TypeDeclaration' => \[
            # defaults
            method      => 'declare'   # export method name
            validate    => 1,          # flag to validate
            print       => 'html'      # 'html', 'text', 'none'
            on\_mismatch => \\&CORE::die # handler
        \]
    \]
);

# DESCRIPTION

Text::Xslate::Bridge::TypeDeclaration is ...

# LICENSE

Copyright (C) pokutuna.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

pokutuna <popopopopokutuna@gmail.com>
