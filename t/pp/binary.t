use v6;

use Test;
use PP::Enc::MIME::Base64;

plan 8;

# from Perl 5 Mime::Base64 base64.t
# I don't think it makes sense any more to test encoding each individual byte
# value but may make sense to do a few end cases
is encode_base64(Buf.new(0)), 'AA==', 'encode Test on NULL/0 byte';
is encode_base64(Buf.new(1)), 'AQ==', 'encode Test on byte value 1';
is encode_base64(Buf.new(255)), '/w==', 'encode Test on byte value 255';
ok decode_base64('AA==') eq Buf.new(0), 'decode Test on NULL/0 byte';
ok decode_base64('AQ==') eq Buf.new(1), 'decode Test on byte value 1';
ok decode_base64('/w==') eq Buf.new(255), 'decode Test on byte value 255';

my Buf $camelia_ico = slurp(
    $?FILE.path.directory ~ '/data/camelia-favicon.ico', :bin
);
# .b64 file generated from .ico file with gnu base64 program
my Str $camelia_b64 = slurp( 
    $?FILE.path.directory ~ '/data/camelia-favicon.b64'
);
is encode_base64($camelia_ico), $camelia_b64.chomp, 'binary img encode test';
ok decode_base64($camelia_b64) eq $camelia_ico, 'binary img decode test';
