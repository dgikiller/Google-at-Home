package IntelliHome::Parser::DB::SQLite;
use Moose;
extends 'IntelliHome::Parser::DB::Base';
use IntelliHome::Schema::SQLite::Schema;
use IntelliHome::Utils qw(load_module);

sub Schema {
    return IntelliHome::Schema::SQLite::Schema->connect(
        'dbi:SQLite:/var/lib/intellihome/intellihome.db');
}

sub search_gpio {
    my $self = shift;
    my $tag  = shift;
    return $self->Schema->resultset('GPIO')
        ->search( { 'tag.tag' => $tag }, { join => [qw/ gpioid /] } );
}

sub search_gpio_pin {
    my $self = shift;
    my $id   = shift;

    my $gpio_rs
        = $self->Schema->resultset('GPIO')->single( { gpioid => $id } );
    return $gpio_rs->search_related('pins')->all;
}

sub search_gpio_id {
    my $self = shift;
    my $id   = shift;

    return $self->Schema->resultset('GPIO')->single( { gpioid => $id } );
}

sub search_trigger {
    my $self    = shift;
    my $trigger = shift;
    return $self->Schema->resultset('Trigger')
        ->search( { trigger => { 'like', '%' . $trigger . '%' } } );
}

sub getTriggers {
    my $self = shift;
    return $self->Schema->resultset('Trigger')->all;
}

sub installPlugin {
    shift->installTrigger($_) for @_;
}

sub installTrigger {
    my $self    = shift;
    my $Options = shift;
    my $Command = shift;
    my $comm    = $self->Schema->resultset('Command')->search(
        {   command => $Command->{'command'},
            plugin  => $Command->{'plugin'}
        }
    );
    return 0 unless ($comm);
    my $Trigger = $self->Schema->resultset('Trigger')
        ->search( { trigger => $Options->{'trigger'} } );
    return 0 unless ($Trigger);
    my $new_trigger = $self->Schema->resultset('Trigger')->new( %{$Options} );
    $new_trigger->command( $comm->commandid );
    return $new_trigger->insert;
}

sub removeTrigger {
    my $self    = shift;
    my $Options = shift;
    my $Trigger = $self->Schema->resultset('Trigger')
        ->search( { trigger => $Options->{'trigger'} } )->delete_all;
}

sub newHypo {
    my $self  = shift;
    my $Hypos = shift;

#  return $_ if IntelliHome::Schema::Mongo::Hypo->find_one( {hypo => $Hypos->{hypo} });
    return IntelliHome::Schema::Mongo::Hypo->new( %{$Hypos} );
}

sub addTask {
    my $self = shift;
    my $Task = shift;
    return IntelliHome::Schema::Mongo::Task->new( %{$Task} );

}

sub addNode {
    my $self    = shift;
    my $Options = shift;
    my $Room    = shift;
    my $r       = $self->Schema->resultset('Room')
        ->search( { name => $Room->{'name'} } );
    return 0 unless ($r);
    my $Node = $self->Schema->resultset('Node')
        ->search( { host => $Options->{'host'} } );
    return 0 unless ($Node);
    my $new_node = $self->Schema->resultset('Node')->new( %{$Options} );
    $new_node->room( $r->roomid );
    return $new_node->insert;
}

sub getNodes {
    my $self  = shift;
    my $Query = shift;
    return $self->Schema->resultset('Node')->search($Query);
}

sub getActiveTasks {
    my $self = shift;
    return IntelliHome::Schema::Mongo::Task->query(
        { status => 1, node => shift->Host } )->all();
}

sub node {
    my $self = shift;
    my $node
        = "IntelliHome::Schema::SQLite::Schema::Result::Node";
    return $node->new() if ( load_module($node) );
}

sub selectFromHost {
    return
        shift->Schema->resultset('Node')
        ->search( { Host => shift, type => shift } )->single;
}

sub selectFromType {
    return
        shift->Schema->resultset('Node')->search( { type => shift } )->single;

}

1;
