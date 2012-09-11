perl6-Enc-MIME-Base64
=================

MIME Base64 encoding for Perl6 that understands Base64 is an encoding for binary data.

# Synopsis

```perl
use PP::Enc::MIME::Base64;

my $http_auth_send = encode_base64_str('Aladdin:open sesame');
my $http_auth_recv = decode_base64_str('QWxhZGRpbjpvcGVuIHNlc2FtZQ==');

my Buf $camelia_ico = slurp(
    $?FILE.path.directory ~ '/data/camelia-favicon.ico', :bin
);
my $camelia_ico_b64 = encode_base64($camelia_ico);

if decode_base64($camelia_ico_b64) eq $camelia_ico {
    say 'Reconstituted icon ok'
}

```

# Functions

## `encode_base64(Buf $b, Str eol = "\n")`

MIME/Base64 encode a Buf of arbitrary binary data.  Return value is a Str. By default breaks up encoding with newline every 76 characters.  To override line breakup pass empty string '' as second parameter.


## `decode_base64(Str $b64)`

Decode a string with MIME/Base64 encoded data into a Buf.

## `encode_base64_str(Str $s, Str $e = 'utf-8', :eol = "\n")`

To make a common case easy this routine Mime/Base64 encodes a string for you.  The result can vary based on your chosen string byte encoding eg utf-8(default) or iso-8859-1/latin-1 or ascii. 

## `decode_base64_str(Str $s, Str $d = 'utf-8')`
To make another common case easy this routine takes a MIME/Base64 encoded string and, after decoding the Base64 into a byte stream Buf, returns a string based on the provided string byte encoding which defaults to utf-8.

# Why another MIME Base64 module

This pure Perl6 implementation is slower but, I believe, more correct in a number of ways.  The existing MIME::Base64 depends on the parrot implementation of the same library which currently has some issues including #826, #814 and #813 on git.  The correctness advantages of this module include:

* Designed to encode/decode binary data with easy wrapper functions for strings.
* Many more tests than the parrot dependent module.  Technically not as many individual tests as the parrot library but that's just because the parrot library tests every individual byte value from 0 to 255 which may not be that useful given how base64 combines bits from adjacent bytes.  I believe that my test suite is actually better than that of the parrot library too.
* Default wrapping of Base64 encoding with newlines every 76 characters as required by MIME.  Configurable and can be turned off for URI data.
* Better interface with exported functions.

Anyway ... I hope you like it.
