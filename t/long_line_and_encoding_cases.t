use v6;

use Test;
use PP::MIME::Base64;

is encode_base64_str(
    'This is a long line whose base64 encoding should be broken into multiple lines as required by MIME.'),
"VGhpcyBpcyBhIGxvbmcgbGluZSB3aG9zZSBiYXNlNjQgZW5jb2Rpbmcgc2hvdWxkIGJlIGJyb2tl
biBpbnRvIG11bHRpcGxlIGxpbmVzIGFzIHJlcXVpcmVkIGJ5IE1JTUUu",
    'Encode Break up long line test';

is encode_base64_str(
    'This is a long line whose base64 encoding should be broken into multiple lines as required by MIME.', eol => ''),
"VGhpcyBpcyBhIGxvbmcgbGluZSB3aG9zZSBiYXNlNjQgZW5jb2Rpbmcgc2hvdWxkIGJlIGJyb2tlbiBpbnRvIG11bHRpcGxlIGxpbmVzIGFzIHJlcXVpcmVkIGJ5IE1JTUUu",
    'Encode Break up long line test with breakup override';

is decode_base64_str(
"VGhpcyBpcyBhIGxvbmcgbGluZSB3aG9zZSBiYXNlNjQgZW5jb2Rpbmcgc2hvdWxkIGJlIGJyb2tl
biBpbnRvIG11bHRpcGxlIGxpbmVzIGFzIHJlcXVpcmVkIGJ5IE1JTUUu"),
    'This is a long line whose base64 encoding should be broken into multiple lines as required by MIME.',
    'Decode Break up long line test';

my $screen_w_accent_e = chr(233) ~ "cran";
is encode_base64_str($screen_w_accent_e, 'latin-1'), '6WNyYW4=', 'latin-1 string encoding test';
is decode_base64_str('6WNyYW4=', 'latin-1'), $screen_w_accent_e, 'latin-1 string decoding test';
is encode_base64_str($screen_w_accent_e), 'w6ljcmFu', 'utf-8 string encoding test';
is decode_base64_str('w6ljcmFu'), $screen_w_accent_e, 'utf-8 string decoding test';

my Buf $camelia_ico = slurp("data/camelia-favicon.ico", :bin);
my Str $camelia_b64 = slurp("data/camelia-favicon.b64");
is encode_base64($camelia_ico), $camelia_b64.chomp, 'binary img encode test';
ok decode_base64($camelia_b64) eq $camelia_ico, 'binary img decode test';
