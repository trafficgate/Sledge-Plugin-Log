# $Id$

use strict;
use Test::More;

use IO::Scalar;

BEGIN {
    eval { require Log::Dispatch::Config; };
    plan $@
	? (skip_all => 'no Log::Dispatch::Config')
	    : (tests => 5);
}

require_ok 'Sledge::Plugin::Log';

package Test::Pages;
use base qw(Sledge::Pages::Base);
use Sledge::Plugin::Log 't/log.cfg';

package main;

{
    my $page = bless {}, 'Test::Pages';
    isa_ok $page->log, 'Log::Dispatch';

    my $err;
    tie *STDERR, 'IO::Scalar', \$err;
    $page->log->info('foo');
    $page->log->debug('foo');
    untie *STDERR;

    like $err, qr/foo/, $err;
    like $err, qr/info/, $err;
    like $err, qr/debug/, $err;
}

