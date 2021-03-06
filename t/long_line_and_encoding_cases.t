use v6;

use Test;
use Enc::MIME::Base64;

plan 6;

is encode_base64_str(
    'This is a long line whose base64 encoding should be broken into multiple lines as required by MIME.'),
"VGhpcyBpcyBhIGxvbmcgbGluZSB3aG9zZSBiYXNlNjQgZW5jb2Rpbmcgc2hvdWxkIGJlIGJyb2tl
biBpbnRvIG11bHRpcGxlIGxpbmVzIGFzIHJlcXVpcmVkIGJ5IE1JTUUu",
    'Encode Break up long line test';

is decode_base64_str(
"VGhpcyBpcyBhIGxvbmcgbGluZSB3aG9zZSBiYXNlNjQgZW5jb2Rpbmcgc2hvdWxkIGJlIGJyb2tl
biBpbnRvIG11bHRpcGxlIGxpbmVzIGFzIHJlcXVpcmVkIGJ5IE1JTUUu"),
    'This is a long line whose base64 encoding should be broken into multiple lines as required by MIME.',
    'Decode Break up long line test';

my $screen_w_accent_e = chr(233) ~ "cran";
is encode_base64_str($screen_w_accent_e, 'iso-8859-1'), '6WNyYW4=', 'latin-1 string encoding test';
is decode_base64_str('6WNyYW4=', 'iso-8859-1'), $screen_w_accent_e, 'latin-1 string decoding test';
is encode_base64_str($screen_w_accent_e), 'w6ljcmFu', 'utf-8 string encoding test';
is decode_base64_str('w6ljcmFu'), $screen_w_accent_e, 'utf-8 string decoding test';
