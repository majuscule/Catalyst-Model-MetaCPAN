# ABSTRACT: A Catalyst Model to interact with the CPAN API
use strict;
use warnings;
package Catalyst::Model::MetaCPAN;

use parent 'Catalyst::Model';

use MetaCPAN::API;

my $mcpan;

sub new {
    my ( $class, $c ) = @_;
    $mcpan = MetaCPAN::API->new();
    my $self = $class->next::method($c);
    return $self;
}

sub distribution_leaderboard {
    my ( $class ) = @_;
    my $results = $mcpan->post(
        'release/_search',
        {
            'facets'  => { 'leaderboard' => { 'terms' => { 'field' => 'distribution', 'size' => 100 } } },
            'size' => 0,
        },
    );
    my $leaderboard = $results->{facets}{leaderboard}{terms};
    return $leaderboard;
}

1;
