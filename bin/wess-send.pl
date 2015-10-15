use v5.10;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUB ZMQ_SUB);
use Time::HiRes q(usleep);

my $endpoint = "tcp://127.0.0.1:3030";
my $ctx      = ZMQ::FFI->new();

my $p = $ctx->socket(ZMQ_PUB);

$p->bind($endpoint);

while (1) {
    warn "Sending";
    $p->send("pid $$ Talking to $endpoint");
    sleep 3;
}
##### This is left here for perl pp to use for executable generation
