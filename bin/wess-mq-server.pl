use v5.10;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUB ZMQ_SUB);
use Time::HiRes q(usleep);

my $endpoint = "tcp://*:3030";
my $ctx      = ZMQ::FFI->new();

my $s = $ctx->socket(ZMQ_SUB);
my $p = $ctx->socket(ZMQ_PUB);

$s->connect($endpoint);
$p->bind($endpoint);

# all topics
{
    $s->subscribe('');

    until ($s->has_pollin) {
        # compensate for slow subscriber
        usleep 100_000;
        $p->send('ohhai');
    }

    say $s->recv();
    # ohhai

    $s->unsubscribe('');
}
