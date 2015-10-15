package WESS::Model;
use Moose;

use WESS::Storage;

has 'storage' => (
    is => 'ro',
    isa => 'WESS::Storage',
    builder => '_storage',
);

# setup delegates here for postgresql and mongodb, redis, etc.

sub _storage {
    my $storage = WESS::Storage->new();
    return $storage;
}

no Moose;
1;
