package Encode::ISO2022::CCS::JISX0213;

use strict;
use warnings;
use base qw(Encode::Encoding);
our $VERSION = '0.01';

use XSLoader;
XSLoader::load('Encode::JISX0213', $VERSION);

foreach my $encoding (qw/jisx0213-plane1 jisx0213-2000-plane1/) {
    foreach my $alt (qw/ascii jis/) {
	$Encode::Encoding{"$encoding-$alt"} = bless {
	    Name => "$encoding-$alt",
	    alt => $alt,
	    encoding => $Encode::Encoding{$encoding},
	} => __PACKAGE__;
    }
}

sub encode {
    my ($self, $utf8) = @_;

    my $residue = '';
    if ($self->{alt} eq 'ascii') {
	if ($utf8 =~ s/([\x21-\x7E].*)$//s) {
	    $residue = $1;
	}
    } elsif ($self->{alt} eq 'jis') {
	if ($utf8 =~ s/([\x21-\x5B\x{00A5}\x5D-\x7D\x{203E}].*)$//s) {
	    $residue = $1;
	}
    }
    my $conv = $self->{encoding}->encode($utf8, 1);

    $_[1] = $utf8 . $residue;
    return $conv;
}

sub decode {
    my ($self, $str) = @_;

    my $conv = $self->{encoding}->decode($str, 1);
    if ($self->{alt} eq 'ascii') {
	$conv =~ tr/\x21-\x7E/\x{FF01}-\x{FF5E}/;
    } elsif ($self->{alt} eq 'jis') {
	$conv =~ tr/\x21-\x5B\x{00A5}\x5D-\x7D\x{203E}/\x{FF01}-\x{FF3B}\x{FFE5}\x{FF3D}-\x{FF5D}\x{FFE3}/;
    }
}

1;
__END__

=head1 NAME

Encode::ISO2022::CCS::JISX0213 - JIS X 0213 coded character sets

=head1 ABSTRACT

  This module provides followng coded character sets.

  reg# Name                  Description
  ----------------------------------------------------------------
  228  jisx0213-2000-plane1  JIS X 0213:2000 level 3 (plane 1)
       jisx0213-2000-plane1-ascii
       jisx0213-2000-plane1-jis
  233  jisx0213-plane1       JIS X 0213:2004 level 3 (plane 1)
       jisx0213-plane1-ascii
       jisx0213-plane1-jis
  229  jisx0213-plane2       JIS X 0213:2000/2004 level 4 (plane 2)
  ----------------------------------------------------------------
  * Ones prefixed "-ascii" and "-jis" use alternative names for the
    characters compatible to ISO646 IRV and JIS X 0201 Latin set,
    respectively.

=head1 DESCRIPTION

FIXME FIXME

=head1 SEE ALSO

L<Encode::ISO2022::CCS>.

=head1 AUTHOR

Hatuka*nezumi - IKEDA Soji <hatuka(at)nezumi.nu>

=head1 COPYRIGHT

Copyright (C) 2013 Hatuka*nezumi - IKEDA Soji.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

