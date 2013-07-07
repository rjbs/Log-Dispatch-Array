use strict;
use warnings;
package Log::Dispatch::Array;
use parent qw(Log::Dispatch::Output);
# ABSTRACT: log events to an array (reference)

=head1 SYNOPSIS

  use Log::Dispatch;
  use Log::Dispatch::Array;

  my $log = Log::Dispatch->new;

  my $target = [];

  $log->add(Log::Dispatch::Array->new(
    name      => 'text_table',
    min_level => 'debug',
    array     => $target,
  ));

  $log->warn($_) for @events;

  # now $target refers to an array of events

=head1 DESCRIPTION

This provides a Log::Dispatch log output system that appends logged events to
an array reference.  This is probably only useful for testing the logging of
your code.

=method new

 my $table_log = Log::Dispatch::Array->new(\%arg);

This method constructs a new Log::Dispatch::Array output object.  Valid
arguments are:

  array - a reference to an array to append to; defaults to an attr on
          $table_log

=cut

sub new {
  my ($class, %arg) = @_;
  $arg{array} ||= [];

  my $self = { array => $arg{array} };

  bless $self => $class;

  # this is our duty as a well-behaved Log::Dispatch plugin
  $self->_basic_init(%arg);

  return $self;
}

=method array

This method returns a reference to the array to which logging is being
performed.

=cut

sub array { $_[0]->{array} }

=method log_message

This is the method which performs the actual logging, as detailed by
Log::Dispatch::Output.

=cut

sub log_message {
  my ($self, %p) = @_;
  push @{ $self->array }, { %p };
}

1;
