package Encode::JISX0213;

use strict;
use warnings;
use Encode::ISO2022;
our @ISA     = qw/Encode::ISO2022/;
our $VERSION = '0.000_07';

use Encode::ISOIRSingle;
use Encode::JISLegacy;
use Encode::JISX0213::CCS;

Encode::define_alias(qr/\beuc-?(jis|jp)-?2004$/i => '"euc-jis-2004"');
$Encode::Encoding{'euc-jis-2004'} = bless {
    'CCS' => [
	{   encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	},
	{encoding => $Encode::Encoding{'c1-ctrl'},},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    gr       => 1,
	    g_init   => 'g1',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
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
	{   encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	},
	{encoding => $Encode::Encoding{'c1-ctrl'},},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    gr       => 1,
	    g_init   => 'g1',
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    gr       => 1,
	    g_init   => 'g3',
	    ss       => "\x8F",
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
	},
    ],
    Name    => 'euc-jisx0213',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?2004$/i => '"iso-2022-jp-2004"');
$Encode::Encoding{'iso-2022-jp-2004'} = bless {
    'CCS' => [
	{   encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x51",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	},

	# Unrecommended encodings.
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	},

	# Nonstandard
    ],
    Name    => 'iso-2022-jp-2004',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?2004-?compatible$/i =>
	'"iso-2022-jp-2004-compatible"');
$Encode::Encoding{'iso-2022-jp-2004-compatible'} = bless {
    'CCS' => [
	{   encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x51",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	},

	# Unrecommended encodings.
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	},

	# Nonstandard
    ],
    Name    => 'iso-2022-jp-2004',
    SubChar => "\x{3013}",
} => __PACKAGE__;

Encode::define_alias(qr/\biso-?2022-?jp-?3$/i => '"iso-2022-jp-3"');
$Encode::Encoding{'iso-2022-jp-3'} = bless {
    'CCS' => [
	{   encoding => $Encode::Encoding{'ascii'},
	    g_init   => 'g0',
	    g_seq    => "\e\x28\x42",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane1-2000-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x4F",
	},
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0213-plane2'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x28\x50",
	},

	# Unrecommended encoding.
	{   bytes    => 2,
	    encoding => $Encode::Encoding{'jis-x-0208-ascii'},
	    g        => 'g0',
	    g_seq    => "\e\x24\x42",
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
  euc-jis-2004      qr/\beuc-?(jis|jp)-?2004$/i   JIS X 0213:2004
  euc-jisx0213      qr/\beucjisx0213$/i           JIS X 0213:2000
                    qr/\beuc.*jp[ \-]?(?:2000|2k)$/i
                    qr/\bjp.*euc[ \-]?(2000|2k)$/i
                    qr/\bujis[ \-]?(?:2000|2k)$/i
  iso-2022-jp-2004  qr/\biso-?2022-?jp-?2004$/i   JIS X 0213:2004
  iso-2022-jp-2004-compatible                     See note.
                    qr/\biso-?2022-?jp-?2004-?compatible$/i
  iso-2022-jp-3     qr/\biso-?2022-?jp-?3$/i      JIS X 0213:2000
  shift_jis-2004    qr/\bshift.*jis.*2004$/i      JIS X 0213:2004
  --------------------------------------------------------------

=head1 DESCRIPTION

To find out how to use this module in detail, see L<Encode>.

=head2 Note on Variants

The encoding suffixed "-compatible" uses JIS X 0208 for the bit combinations
co-existing on JIS X 0208 and JIS X 0213 plane 1.  It is I<not> compatible
to normal encodings; it had never been registered by any standards bodies.

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
