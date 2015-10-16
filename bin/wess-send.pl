package WESS::Bin::Client;

use v5.10;

use Moose;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUSH);

use Time::HiRes q(usleep);

has 'endpoint' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'tcp://127.0.0.1:3030',
);

has 'context' => (
    is      => 'ro',
    isa     => 'ZMQ::FFI::ZMQ3::Context',
    builder => '_context',
    lazy    => 1,
);

has 'socket' => (
    is      => 'ro',
    isa     => 'ZMQ::FFI::ZMQ3::Socket',
    builder => '_socket',
    lazy    => 1,
);

sub _context {
    my ($self) = @_;
    my $context = ZMQ::FFI->new();
    return $context;
}

sub _socket {
    my ($self) = @_;
    my $socket = $self->context->socket(ZMQ_PUSH);
    $socket->connect($self->endpoint);
    return $socket;
}

sub send {
    my ($self, $zmq_data) = @_;
    $self->socket->send($zmq_data);
}

package main;

my $client = WESS::Bin::Client->new();

my $message = "pid $$ Talking to " . $client->endpoint;

$client->send($message);

1;
