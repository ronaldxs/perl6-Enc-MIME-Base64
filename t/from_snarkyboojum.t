use v6;

use Test;
use PP::Enc::MIME::Base64;

plan 18;

is encode_base64_str(''), '', 'Encoding the empty string';
is encode_base64_str('A'), 'QQ==', 'Encoding "A"';
is encode_base64_str('Ab'), 'QWI=', 'Encoding "Ab"';
is encode_base64_str('Abc'), 'QWJj', 'Encoding "Abc"';
is encode_base64_str('Abcd'), 'QWJjZA==', 'Encoding "Abcd"';
is encode_base64_str('Perl'), 'UGVybA==', 'Encoding "Perl"';
is encode_base64_str('Perl6'), 'UGVybDY=', 'Encoding "Perl6"';
is encode_base64_str('Another test!'), 'QW5vdGhlciB0ZXN0IQ==', '"Encoding "Another test!"';
is encode_base64_str('username:thisisnotmypassword'), 'dXNlcm5hbWU6dGhpc2lzbm90bXlwYXNzd29yZA==', 'Encoding "username:thisisnotmypassword"';

is decode_base64_str(''), '', 'Decoding the empty string';
is decode_base64_str('QQ=='), 'A', 'Decoding "A"';
is decode_base64_str('QWI='), 'Ab', 'Decoding "Ab"';
is decode_base64_str('QWJj'), 'Abc', 'Decoding "Abc"';
is decode_base64_str('QWJjZA=='), 'Abcd', 'Decoding "Abcd"';
is decode_base64_str('UGVybA=='), 'Perl', 'Decoding "Perl"';
is decode_base64_str('UGVybDY='), 'Perl6', 'Decoding "Perl6"';
is decode_base64_str('QW5vdGhlciB0ZXN0IQ=='), 'Another test!', '"Decoding "Another test!"';
is decode_base64_str('dXNlcm5hbWU6dGhpc2lzbm90bXlwYXNzd29yZA=='), 'username:thisisnotmypassword', 'Decoding "username:thisisnotmypassword"';
