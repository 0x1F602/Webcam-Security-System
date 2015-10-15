package WESS::Controller;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;

extends 'Mojolicious::Controller';

use WESS::Model;

has 'model' => (
    is => 'ro',
    isa => 'WESS::Model',
    builder => '_model',
);

sub _model {
    my $model = WESS::Model->new;
    return $model;
}

no Moose;
1;
