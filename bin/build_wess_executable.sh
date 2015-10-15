pp -o wess-send \
    -M FFI::Platypus::Lang::C \
    -M ZMQ::FFI::SocketRole \
    -M ZMQ::FFI::ErrorHelper \
    -M ZMQ::FFI::Versioner \
    -M ZMQ::FFI::ContextRole \
    -c wess-send.pl
