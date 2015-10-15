use v5.10;
use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PULL);
use Time::HiRes q(usleep);

my $endpoint = "tcp://127.0.0.1:3030";
my $ctx      = ZMQ::FFI->new();

my $s = $ctx->socket(ZMQ_PULL);

$s->bind($endpoint);

my ($command) = @ARGV;

if ($command eq 'start') {
    say "Starting ZMQ PULL server";
    while (1) {
        until ($s->has_pollin) {
            # compensate for slow subscriber
            usleep 100_000;
        }
        say $s->recv();
    }
}
