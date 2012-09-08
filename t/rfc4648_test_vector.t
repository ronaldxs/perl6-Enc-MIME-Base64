use v6;

# from http://tools.ietf.org/html/rfc4648#section-10

use Test;
use PP::MIME::Base64::Str;

plan 7;

my PP::MIME::Base64::Str $mime .= new;

is $mime.encode(""), '', 'Encoding the empty string';
is $mime.encode("f"), 'Zg==', 'Encoding "f"';
is $mime.encode("fo"), 'Zm8=', 'Encoding "fo"';
is $mime.encode("foo"), 'Zm9v', 'Encoding "foo"';
is $mime.encode("foob"), 'Zm9vYg==', 'Encoding "foob"';
is $mime.encode("fooba"), 'Zm9vYmE=', 'Encoding "fooba"';
is $mime.encode("foobar"), 'Zm9vYmFy', 'Encoding "foobar"';
