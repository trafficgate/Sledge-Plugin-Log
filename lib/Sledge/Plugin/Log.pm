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

C<Log::Dispatch::Config> モジュールをアドオンするプラグインです。

=head1 METHODS

Sledge::Plugin::Log をC<use>することで、PagesクラスにC<log>メソッドが
インポートされます。C<log> メソッドは Log::Dispatch インスタンスへのア
クセサ (read only) です。C<use> の後に Log::Dispatch::Config の 
C<config()> メソッドに引き渡す設定ファイルを指定します。省略すると 
C</dev/null> となり、ログは何も出力されません。利用可能なレベルや設定
ファイルの書式はL<Log::Dispatch::Config> や C<eg/log.cfg> を参照してく
ださい。

=head1 AUTHOR

Tatsuhiko Miyagawa <miyagawa@edge.co.jp> with Sledge development team.

=head1 SEE ALSO

L<Log::Dispatch::Config>

=cut


