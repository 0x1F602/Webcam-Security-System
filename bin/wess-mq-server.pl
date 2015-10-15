use v5.10;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUB ZMQ_SUB);
use Time::HiRes q(usleep);

my $endpoint = "tcp://127.0.0.1:3030";
my $ctx      = ZMQ::FFI->new();

my $s = $ctx->socket(ZMQ_SUB);

$s->connect($endpoint);

my ($command) = @ARGV;

if ($command eq 'start') {
    $s->subscribe('');
    while (1) {
        say "Listening for more messages $$";
        until ($s->has_pollin) {
            # compensate for slow subscriber
            usleep 100_000;
        }
        warn $s->recv();

        say $s->recv();
    }
}
