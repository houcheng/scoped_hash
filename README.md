# Scoped hash library

It provides scoped view to a hash (mash) data structure.
When the requested scope does not exist, it would fall back to the non-scope key.

    require 'scoped_hash'
    smash = ScopedHash.new( 'tax': { min: 20, max: 40},
        'tax(democratic)': { min: 30, max: 50},
        'tax(republican)': { min: 10, max: 30})

    smash.scope('democratic')[:tax][:min] == 30
    smash.scope('republican')[:tax][:min] == 10
    smash.scope('green')[:tax][:min] == 20

## Installation

Simply use gem to install this library:

    gem install scoped_hash

