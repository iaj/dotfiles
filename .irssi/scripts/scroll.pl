# XXX

# Copyright (C) 2009  Simon Ruderich
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


use strict;
use warnings;

use Irssi ();

our $VERSION = '0.1';
our %IRSSI = (
    authors     => 'Simon Ruderich',
    contact     => 'simon@ruderich.org',
    name        => 'scroll',
    description => 'Scrolls to first (from bottom) occurrence of regex.',
    license     => 'GPLv3 or later',
    url         => 'XXX',
    changed     => 'XXX'
);

sub scroll_command {
    my ($data, $server, $window_item) = @_;

    return unless $data;

    my $window = Irssi::active_win();
    my $view   = $window->view();

    # Get first line in current view, abort if there are none.
    my $line = $view->get_lines();
    return unless defined $line;

    # Get all lines.
    my @lines;
    while (1) {
        push @lines, $line;

        last unless defined $line->next();
        $line = $line->next();
    }

    # Scroll to first line (thus reverse is necessary) matching the regex.
    foreach my $line (reverse @lines) {
        if ($line->get_text(0) =~ $data) {
            $view->scroll_line($line);
            last;
        }
    }
}

Irssi::command_bind('scroll', \&scroll_command);
