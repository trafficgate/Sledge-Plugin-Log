package Sledge::Plugin::Log;
# $Id$
#
# Tatsuhiko Miyagawa <miyagawa@edge.co.jp>
# Livin' On The EDGE, Limited.
#

use strict;
use vars qw($VERSION);
$VERSION = 0.02;

use Log::Dispatch::Config;

sub import {
    my($class, $cfg) = @_;
    my $pkg = caller;

    $cfg ||= '/dev/null';

    no strict 'refs';
    *{"$pkg\::log"} = sub {
	my $self = shift;
	$self->{log} = _instance($cfg) unless $self->{log};
	return $self->{log};
    };
}

sub _instance {
    my $cfg = shift;
    Log::Dispatch::Config->configure($cfg);
    return Log::Dispatch::Config->instance;
}

1;

