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
