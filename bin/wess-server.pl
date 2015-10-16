package WESS::Bin::Server;

use v5.10;

use Moose;

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PULL);

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
    my $socket = $self->context->socket(ZMQ_PULL);
    $socket->bind($self->endpoint);
    return $socket;
}

sub wait_loop {
    my ($self, $callback) = @_;
    while (1) {
        until ($self->socket->has_pollin) {
            usleep 100_000;
        }
        my $zmq_data = $self->socket->recv();
        $callback->($zmq_data);
    }
}

package main;

my ($command) = @ARGV;

sub usage {
    say "Usage: $0 [start]";
}

if (not defined $command) {
    usage();
    die;
}

if ($command eq 'start') {
    say "Starting ZMQ PULL server";
    my $server = WESS::Bin::Server->new();
    $server->wait_loop(sub {
        my ($message) = @_;
        say $message;
    });
}
else {
    usage();
}

1;
