package WESS::Storage;

use strict;
use warnings;

use Moose;

sub pg {
    warn 'accessed pg';
}

sub mongo {
    warn 'accessed mongo';
}

no Moose;
1;
