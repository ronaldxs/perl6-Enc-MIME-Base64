use v6;

use Test;
use PP::MIME::Base64::Str;

plan 9;

my PP::MIME::Base64::Str $mime .= new;

is $mime.encode(""), '', 'Encoding the empty string';
is $mime.encode("A"), 'QQ==', 'Encoding "A"';
is $mime.encode("Ab"), 'QWI=', 'Encoding "Ab"';
is $mime.encode("Abc"), 'QWJj', 'Encoding "Abc"';
is $mime.encode("Abcd"), 'QWJjZA==', 'Encoding "Abcd"';
is $mime.encode("Perl"), 'UGVybA==', 'Encoding "Perl"';
is $mime.encode("Perl6"), 'UGVybDY=', 'Encoding "Perl6"';
is $mime.encode("Another test!"), 'QW5vdGhlciB0ZXN0IQ==', '"Encoding "Another test!"';
is $mime.encode("username:thisisnotmypassword"), 'dXNlcm5hbWU6dGhpc2lzbm90bXlwYXNzd29yZA==', 'Encoding "username:thisisnotmypassword"';
