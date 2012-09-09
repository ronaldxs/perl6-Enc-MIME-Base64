use v6;

# from http://tools.ietf.org/html/rfc4648#section-10

use Test;
use PP::MIME::Base64;

plan 14;

is encode_base64_str(''), '', 'Encoding the empty string';
is encode_base64_str('f'), 'Zg==', 'Encoding "f"';
is encode_base64_str('fo'), 'Zm8=', 'Encoding "fo"';
is encode_base64_str('foo'), 'Zm9v', 'Encoding "foo"';
is encode_base64_str('foob'), 'Zm9vYg==', 'Encoding "foob"';
is encode_base64_str('fooba'), 'Zm9vYmE=', 'Encoding "fooba"';
is encode_base64_str('foobar'), 'Zm9vYmFy', 'Encoding "foobar"';

is decode_base64_str(''), '', 'Decoding the empty string';
is decode_base64_str('Zg=='), 'f', 'Decoding "f"';
is decode_base64_str('Zm8='), 'fo', 'Decoding "fo"';
is decode_base64_str('Zm9v'), 'foo', 'Decoding "foo"';
is decode_base64_str('Zm9vYg=='), 'foob', 'Decoding "foob"';
is decode_base64_str('Zm9vYmE='), 'fooba', 'Decoding "fooba"';
is decode_base64_str('Zm9vYmFy'), 'foobar', 'Decoding "foobar"';

