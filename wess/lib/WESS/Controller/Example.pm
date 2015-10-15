package WESS::Controller::Example;

use strict;
use warnings;

use Moose;

extends 'WESS::Controller';

# This action will render a template
sub welcome {
    my ($self) = @_;
    
    $self->model->storage->pg;
    $self->model->storage->mongo;
    # Render template "example/welcome.html.ep" with message
    $self->render(msg => 'WESS - WEbcam Security System');
}

no Moose;
1;
