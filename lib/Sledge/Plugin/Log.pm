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

__END__

=head1 NAME

Sledge::Plugin::Log - Sledge Log configurator

=head1 SYNOPSIS

  package Foo::Pages::Bar;
  use Sledge::Plugin::Log '/path/to/config';

  sub dispatch_foo {
      my $self = shift;
      $self->log->debug('some piece of message');
      $self->log->emerge('Emergency!');
  }

=head1 DESCRIPTION

C<Log::Dispatch::Config> �⥸�塼��򥢥ɥ��󤹤�ץ饰����Ǥ���

=head1 METHODS

Sledge::Plugin::Log ��C<use>���뤳�Ȥǡ�Pages���饹��C<log>�᥽�åɤ�
����ݡ��Ȥ���ޤ���C<log> �᥽�åɤ� Log::Dispatch ���󥹥��󥹤ؤΥ�
������ (read only) �Ǥ���C<use> �θ�� Log::Dispatch::Config �� 
C<config()> �᥽�åɤ˰����Ϥ�����ե��������ꤷ�ޤ�����ά����� 
C</dev/null> �Ȥʤꡢ���ϲ�����Ϥ���ޤ������Ѳ�ǽ�ʥ�٥������
�ե�����ν񼰤�L<Log::Dispatch::Config> �� C<eg/log.cfg> �򻲾Ȥ��Ƥ�
��������

=head1 AUTHOR

Tatsuhiko Miyagawa <miyagawa@edge.co.jp> with Sledge development team.

=head1 SEE ALSO

L<Log::Dispatch::Config>

=cut


