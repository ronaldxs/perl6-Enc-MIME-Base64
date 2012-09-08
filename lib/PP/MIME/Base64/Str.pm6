use PP::MIME::Base64;

class PP::MIME::Base64::Str {
#    method encode(Str $s, Str $e = 'utf8' --> Str) {
    method encode(Str $s, Str $e = 'utf8') {
        PP::MIME::Base64.encode($s.encode($e));
    }
#    method decode(Str $s, Str $d = 'utf8' --> Buf) {
    method decode(Str $s, Str $d = 'utf8') {
        PP::MIME::Base64.decode($s).decode($d);
    }

}
