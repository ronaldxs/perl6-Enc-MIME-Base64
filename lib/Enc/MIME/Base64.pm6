module Enc::MIME::Base64:auth<ronaldxs>:ver<0.01> {

    pir::load_bytecode__vs('MIME/Base64.pbc');

    our Str sub encode_base64(Buf $b, Str $eol = "\n") is export {
        if $eol ne "\n" {
            die "eol parameter only supported in PurePerl for now"
        }
        my Mu $b_internal := nqp::getattr(nqp::p6decont($b), Buf, '$!buffer');
        my $encoded-str = nqp::p6box_s Q:PIR {
            .local pmc encode
            encode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'encode_base64_bb'
            $P0 = find_lex '$b_internal'
            %r = encode($P0)
        };
        return $encoded-str;        
    }

    ######################################################################
    # Greatly wondering whether building everything in a list of Int
    # and then newing the Buf is the most efficient way
    ######################################################################
    our Buf sub decode_base64(Str $s) is export {
        my $ret := Buf.new();
#        my $bb := pir::new__Ps('ByteBuffer');
        my $bb := Q:PIR {
            .local pmc decode
            decode = get_root_global ['parrot'; 'MIME'; 'Base64'], 'decode_base64_bb'
            $P1 = find_lex '$s'
            $S1 = repr_unbox_str $P1
            %r = decode($S1)
        };
        nqp::bindattr($ret, Buf, '$!buffer', $bb);
        return $ret;   
    }

    ######################################################################
    our Str sub encode_base64_str(Str $s, Str $e = 'utf-8', :$eol = "\n")
        is export
    {
        if $eol ne "\n" {
            die "eol parameter only supported in PurePerl for now"
        }
        encode_base64($s.encode($e), $eol);
    }

    ######################################################################
    our Str sub decode_base64_str(Str $s, Str $d = 'utf-8')
        is export
    {
        decode_base64($s).decode($d);
    }

}
