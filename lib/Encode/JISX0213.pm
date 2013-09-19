package Encode::JISX0213;

use strict;
use warnings;
use base qw(Encode::ISO2022);
our $VERSION = '0.01_03';

use Encode::ISOIRSingle;
use Encode::JISLegacy;
use Encode::JISX0213::CCS;

Encode::define_alias(qr/\beuc-?(jis|jp)-?2004$/i => '"euc-jis-2004"');
$Encode::Encoding{'euc-jis-2004'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	},
	{encoding => $Encode::Encoding{'c1-ctrl'},},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    gr       => 1,
	    g_init   => 'g1',
	    range    => '\xA1-\xFE',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
	    range    => '\xA1-\xFE',
	},

	# Unrecommended encodings
	{   encoding => $Encode::Encoding{'jis-x-0201-right'},
	    gr       => 1,
	    g_init   => 'g2',
	    ss       => "\x8E",
	},

	# Nonstandard
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0212-ascii'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
	    range    => '\xA1-\xFE',
	},
    ],
    Init    => '',
    Name    => 'euc-jis-2004',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\beucjisx0213$/i              => '"euc-jisx0213"');
Encode::define_alias(qr/\beuc.*jp[ \-]?(?:2000|2k)$/i => '"euc-jisx0213"');
Encode::define_alias(qr/\bjp.*euc[ \-]?(2000|2k)$/i   => '"euc-jisx0213"');
Encode::define_alias(qr/\bujis[ \-]?(?:2000|2k)$/i    => '"euc-jisx0213"');
$Encode::Encoding{'euc-jisx0213'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	},
	{encoding => $Encode::Encoding{'c1-ctrl'},},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    gr       => 1,
	    g_init   => 'g1',
	    range    => '\xA1-\xFE',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
	    range    => '\xA1-\xFE',
	},

	# Unrecommended encodings
	{   encoding => $Encode::Encoding{'jis-x-0201-right'},
	    gr       => 1,
	    g_init   => 'g2',
	    ss       => "\x8E",
	},

	# Nonstandard
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0212-ascii'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
	    range    => '\xA1-\xFE',
	},
    ],
    Name    => 'euc-jisx0213',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?2004$/i => '"iso-2022-jp-2004"');
$Encode::Encoding{'iso-2022-jp-2004'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x51",
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	    range    => '\x21-\x7E',
	},

	# Unrecommended encodings.
	{   bytes    => 2,
	    dec_only => 1,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	    ss       => '', # encodes runs as short as possible
	    range    => '\x21-\x7E',
	},

	# Nonstandard
    ],
    Name    => 'iso-2022-jp-2004',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?2004-?strict$/i =>
	'"x-iso-2022-jp-2004-strict"');
$Encode::Encoding{'x-iso-2022-jp-2004-strict'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-0213-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x51",
	    ss       => '', # encodes runs as short as possible
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	    range    => '\x21-\x7E',
	},

	# Unrecommended encodings.
	{   bytes    => 2,
	    dec_only => 1,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	    range    => '\x21-\x7E',
	},

	# Nonstandard
    ],
    Name    => 'x-iso-2022-jp-2004-strict',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?2004-?compatible$/i =>
	'"x-iso-2022-jp-2004-compatible"');
$Encode::Encoding{'x-iso-2022-jp-2004-compatible'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x51",
	    ss       => '', # encodes runs as short as possible
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	    range    => '\x21-\x7E',
	},

	# Unrecommended encodings.
	{   bytes    => 2,
	    dec_only => 1,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	    range    => '\x21-\x7E',
	},

	# Nonstandard
    ],
    Name    => 'x-iso-2022-jp-2004-compatible',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?3$/i => '"iso-2022-jp-3"');
$Encode::Encoding{'iso-2022-jp-3'} = bless {
    'CCS' => [
	{   cl       => 1,
	    encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	    range    => '\x21-\x7E',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	    range    => '\x21-\x7E',
	},

	# Unrecommended encoding.
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	    ss       => '', # encodes runs as short as possible
	    range    => '\x21-\x7E',
	},

	# Nonstandard
    ],
    Name    => 'iso-2022-jp-3',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\bshift.*jis.*2004$/, '"shift_jis-2004"');

1;
__END__

=encoding utf-8

=head1 NAME

Encode::JISX0213 - JIS X 0213 encodings

=head1 SYNOPSIS

    use Encode::JISX0213;
    use Encode qw/encode decode/;
    $byte = encode("iso-2022-jp-2004", $utf8);
    $utf8 = decode("iso-2022-jp-2004", $byte);

=head1 ABSTRACT

This module provides following encodings.

  Canonical         Alias                         Description
  --------------------------------------------------------------
  euc-jis-2004      qr/\beuc-?(jis|jp)-?2004$/i   EUC encoding
  iso-2022-jp-2004  qr/\biso-?2022-?jp-?2004$/i   7-bit encoding
  shift_jis-2004    qr/\bshift.*jis.*2004$/i      "shift" encoding
  --------------------------------------------------------------

For older release of JIS X 0213:

  Canonical         Alias                         Description
  --------------------------------------------------------------
  euc-jisx0213      qr/\beucjisx0213$/i           JIS X 0213:2000
                    qr/\beuc.*jp[ \-]?(?:2000|2k)$/i
                    qr/\bjp.*euc[ \-]?(2000|2k)$/i
                    qr/\bujis[ \-]?(?:2000|2k)$/i
  iso-2022-jp-3     qr/\biso-?2022-?jp-?3$/i      JIS X 0213:2000
  --------------------------------------------------------------

For transition from legacy standards:

  Canonical         Alias                         Description
  --------------------------------------------------------------
  x-iso-2022-jp-2004-compatible                   See note.
                    qr/\biso-?2022-?jp-?2004-?compatible$/i
  x-iso-2022-jp-2004-strict                       See note.
                    qr/\biso-?2022-?jp-?2004-?strict$/i
  --------------------------------------------------------------

=head1 DESCRIPTION

To find out how to use this module in detail, see L<Encode>.

=head2 Note on Variants

C<x-iso-2022-jp-2004-strict> uses JIS X 0208 as much as possible,
strictly confirming JIS X 0213:2004.
It is compatible to other encodings.

C<x-iso-2022-jp-2004-compatible> uses JIS X 0208 for the bit combinations
co-existing on JIS X 0208 and JIS X 0213 plane 1.
It is I<not> compatible to other encodings;
it had never been registered by any standards bodies.

However, all encodings above
perform C<-compatible> behavior to decode byte strings.
Exception is C<x-iso-2022-jp-2004-strict>:
it accepts only allowed JIS X 0208 sequences.

=head1 SEE ALSO

JIS X 0213:2000
I<7ビット及び8ビットの2バイト情報交換用符号化拡張漢字集合>
(I<7-bit and 8-bit double byte coded extended KANJI sets for information
interchange>), and its amendment JIS X 0213:2000/AMENDMENT 1:2004.

L<Encode>, L<Encode::JP>, L<Encode::ISO2022JP2>.

=head1 AUTHOR

Hatuka*nezumi - IKEDA Soji <hatuka(at)nezumi.nu>

=head1 COPYRIGHT

Copyright (C) 2013 Hatuka*nezumi - IKEDA Soji.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
