# $Id$

use strict;
use Test::More;

use IO::Scalar;

BEGIN {
    eval { require Log::Dispatch::Config; };
    plan $@
	? (skip_all => 'no Log::Dispatch::Config')
	    : (tests => 9);
}

require_ok 'Sledge::Plugin::Log';

package Test::Pages;
use base qw(Sledge::Pages::Base);
use Sledge::Plugin::Log 't/log.cfg';

package Another::Pages;
use base qw(Sledge::Pages::Base);
use Sledge::Plugin::Log 't/another.cfg';

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

{
    my $page = bless {}, 'Another::Pages';
    isa_ok $page->log, 'Log::Dispatch';

    my $err;
    tie *STDERR, 'IO::Scalar', \$err;
    $page->log->info('foo');
    $page->log->debug('foo');
    $page->log->emergency('bazbaz');
    untie *STDERR;

    unlike $err, qr/foo/, $err;
    unlike $err, qr/info/, $err;
    unlike $err, qr/debug/, $err;
}

