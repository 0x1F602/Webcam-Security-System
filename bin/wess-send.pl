use v5.10;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUSH);
use Time::HiRes q(usleep);

my $endpoint = "tcp://127.0.0.1:3030";
my $ctx      = ZMQ::FFI->new();

my $p = $ctx->socket(ZMQ_PUSH);

$p->connect($endpoint);

my $message = "pid $$ Talking to $endpoint";
while (1) {
    say "Sending $message";
    $p->send($message);
    sleep 3;
}
##### This is left here for perl pp to use for executable generation
