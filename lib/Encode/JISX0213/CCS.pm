package Encode::JISX0213::CCS;

use strict;
use warnings;
use base qw(Encode::Encoding);
our $VERSION = '0.01';

use Carp qw(carp croak);
use XSLoader;
XSLoader::load('Encode::JISX0213', $VERSION);

my $err_encode_nomap = '"\x{%*v04X}" does not map to %s';

my $DIE_ON_ERR = Encode::DIE_ON_ERR();
my $LEAVE_SRC = Encode::LEAVE_SRC();
my $PERLQQ = Encode::PERLQQ();
my $WARN_ON_ERR = Encode::WARN_ON_ERR();

foreach my $encoding (
    qw/jis-x-0208 jis-x-0213-plane1 jis-x-0213-plane1-2000/
) {
    foreach my $alt ('', 'ascii', 'jis') {
	my $name = $encoding . ($alt ? "-$alt" : "");
	$Encode::Encoding{$name} = bless {
	    Name => $name,
	    alt => $alt,
	    encoding => $Encode::Encoding{"$encoding-canonic"},
	    jisx0213 => ($name =~ /jis-x-0213/ ? 1 : 0),
	} => __PACKAGE__;
    }
}

# Workaround for encengine.c which cannot correctly map Unicode sequence
# with multiple characters.
my %composed = (
    "\x{304B}\x{309A}" => "\x24\x77",
    "\x{304D}\x{309A}" => "\x24\x78",
    "\x{304F}\x{309A}" => "\x24\x79",
    "\x{3051}\x{309A}" => "\x24\x7A",
    "\x{3053}\x{309A}" => "\x24\x7B",
    "\x{30AB}\x{309A}" => "\x25\x77",
    "\x{30AD}\x{309A}" => "\x25\x78",
    "\x{30AF}\x{309A}" => "\x25\x79",
    "\x{30B1}\x{309A}" => "\x25\x7A",
    "\x{30B3}\x{309A}" => "\x25\x7B",
    "\x{30BB}\x{309A}" => "\x25\x7C",
    "\x{30C4}\x{309A}" => "\x25\x7D",
    "\x{30C8}\x{309A}" => "\x25\x7E",
    "\x{31F7}\x{309A}" => "\x26\x78",
    "\x{00E6}\x{0300}" => "\x2B\x44",
    "\x{0254}\x{0300}" => "\x2B\x48",
    "\x{0254}\x{0301}" => "\x2B\x49",
    "\x{028C}\x{0300}" => "\x2B\x4A",
    "\x{028C}\x{0301}" => "\x2B\x4B",
    "\x{0259}\x{0300}" => "\x2B\x4C",
    "\x{0259}\x{0301}" => "\x2B\x4D",
    "\x{025A}\x{0300}" => "\x2B\x4E",
    "\x{025A}\x{0301}" => "\x2B\x4F",
    "\x{0301}"         => "\x2B\x5A",
    "\x{0300}"         => "\x2B\x5C",
    "\x{02E5}"         => "\x2B\x60",
    "\x{02E9}"         => "\x2B\x64",
    "\x{02E9}\x{02E5}" => "\x2B\x65",
    "\x{02E5}\x{02E9}" => "\x2B\x66",
);

sub encode {
    my ($self, $utf8, $chk) = @_;

    my $chk_flags = $chk;
    if (ref $chk) {
	$chk_flags = $LEAVE_SRC | $PERLQQ;
    }

    my $conv;
    my $residue = '';

    if ($self->{jisx0213} and
	$self->{alt} eq 'ascii' and $utf8 =~ s/([\x21-\x7E].*)$//s or
	not $self->{jisx0213} and
	$self->{alt} eq 'ascii' and $utf8 =~ s/([\x21-\x5B\x5D-\x7D].*)$//s or
	$self->{alt} eq 'jis' and
	$utf8 =~ s/([\x21-\x5B\x{00A5}\x5D-\x7D\x{203E}].*)$//s) {
	$residue = $1;
	if ($chk_flags & $DIE_ON_ERR) {
	    croak sprintf $err_encode_nomap, '}\x{', substr($residue, 0, 1);
	}
    }

    # JIS X 0208
    unless ($self->{jisx0213}) {
	if ($utf8 =~ s/(.[\x{0300}-\x{036F}\x{309A}].*)$//s) {
	    $residue = $1 . $residue;
	}
	$conv = $self->{encoder}->encode($utf8, $chk);
	goto ENCODE_LAST;
    }

    # JIS X 0213
    while ($utf8 =~
	s{  \A
	    (.*?)
	    (
		\x{02E9} \x{02E5} |
		\x{02E5} \x{02E9} |
		. [\x{0300}\x{0301}\x{309A}] |
		[\x{02E5}\x{02E9}\x{0300}\x{0301}] |
		\z
	    )
	}{}sx
    ) {
	my ($chunk, $mc) = ($1, $2);
	last unless length $chunk or length $mc;

	if (length $chunk) {
	    $conv .= $self->{encoding}->encode(
		$chunk,
		(ref($chk) ? $chk : ($chk_flags & ~$LEAVE_SRC))
	    );
	}
	if (length $chunk) {
	    $utf8 = $chunk . $mc . $utf8;
	    last;
	}

	next unless length $mc;
	if ($composed{$mc}) {
	    $conv .= $composed{$mc};
	    next;
	}
	$conv .= $self->{encoding}->encode(
	    $mc,
	    (ref($chk) ? $chk : ($chk_flags & ~$LEAVE_SRC))
	);
	if (length $mc) {
	    $utf8 = $mc . $utf8;
	    last;
	}
    }

  ENCODE_LAST:
    if (not length $utf8 and length $residue) {
	if ($chk_flags & $WARN_ON_ERR) {
	    carp sprintf $err_encode_nomap, '}\x{', substr($residue, 0, 1);
	}
	#FIXME:"best efort" replacement
    }

    $_[1] = $utf8 . $residue unless $chk_flags & $LEAVE_SRC;
    return $conv;
}

sub decode {
    my ($self, $str, $chk) = @_;

    my $conv = $self->{encoding}->decode($str, $chk);
    if ($self->{alt} eq 'ascii') {
	$conv =~ tr/\x21-\x7E/\x{FF01}-\x{FF5E}/;
    } elsif ($self->{alt} eq 'jis') {
	$conv =~ tr/\x21-\x5B\x{00A5}\x5D-\x7D\x{203E}/\x{FF01}-\x{FF3B}\x{FFE5}\x{FF3D}-\x{FF5D}\x{FFE3}/;
    }

    $_[1] = $str;
    return $conv;
}

1;
__END__

=head1 NAME

Encode::JISX0213::CCS - JIS X 0213 coded character sets

=head1 ABSTRACT

This module provides followng coded character sets.

  reg# Name                    Description
  ----------------------------------------------------------------
   87  jis-x-0208              JIS X 0208-1983, 2nd rev. of JIS X 0208
  168      ditto               JIS X 0208-1990, 3rd rev. of JIS X 0208
       jis-x-0208-ascii
       jis-x-0208-jis
  233  jis-x-0213-plane1       JIS X 0213:2004 level 3 (plane 1)
       jis-x-0213-plane1-ascii
       jis-x-0213-plane1-jis
  228  jis-x-0213-plane1-2000  JIS X 0213:2000 level 3 (plane 1)
       jis-x-0213-plane1-2000-ascii
       jis-x-0213-plane1-2000-jis
  229  jis-x-0213-plane2       JIS X 0213:2000/2004 level 4 (plane 2)
  ----------------------------------------------------------------

=head1 DESCRIPTION

=head2 Note on Variants

Those prefixed "-ascii" and "-jis" use alternative names for the characters
compatible to ISO/IEC 646 IRV and JIS X 0201 Latin set, respectively.

=head1 SEE ALSO

L<Encode::ISO2022::CCS>.

=head1 AUTHOR

Hatuka*nezumi - IKEDA Soji <hatuka(at)nezumi.nu>

=head1 COPYRIGHT

Copyright (C) 2013 Hatuka*nezumi - IKEDA Soji.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

