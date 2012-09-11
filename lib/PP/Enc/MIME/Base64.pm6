module PP::Enc::MIME::Base64:auth<ronaldxs>:ver<0.01> {
    our Str constant @mapping =
        flat 'A' .. 'Z', 'a' .. 'z', '0' .. '9', '+', '/';

    # think about making this an our constant too some day
    my %reverse_mapping = (^64).map: { ; @mapping[ $_ ] => $_ };

    # rfc 4648 gives http://josefsson.org/base-encoding/ as almost
    # but not quite a reference implementation.  I don't follow
    # that implementation here but note it for anyone considering
    # a parrot or external library implementation

    ######################################################################
    our Str sub encode_base64(Buf $b, Str $eol = "\n") is export {
        my Str $rc = '';
        my Str $padding_suffix = '';

        my $line_break_counter = 0;
        for $b.list -> $byte1, $byte2?, $byte3? {
            $rc ~= @mapping[ $byte1 +& 0b11111100 +> 2 ];
            if $byte2.defined {
                $rc ~= @mapping[
                        $byte1 +&  0b00000011 +< 4 +
                        $byte2 +&  0b11110000 +> 4
                ];
                if $byte3.defined {
                    $rc ~= @mapping[
                            $byte2 +&  0b00001111 +< 2 +
                            $byte3 +&  0b11000000 +> 6
                        ] ~
                        @mapping[ $byte3 +& 0b00111111 ];
                }
                else {
                    $rc ~= @mapping[ $byte2 +& 0b00001111 +< 2 ];
                    $padding_suffix ~= '=';
                }
            }
            else {
                $rc ~= @mapping[ $byte1 +&  0b00000011 +< 4 ];
                $padding_suffix ~= '==';
            }
            # more precise research on newline later
            if ++$line_break_counter % 19 == 0 { $rc ~= $eol}
        } 

        return $rc ~ $padding_suffix;
    }

    ######################################################################
    # Greatly wondering whether building everything in a list of Int
    # and then newing the Buf is the most efficient way
    ######################################################################
    our Buf sub decode_base64(Str $s) is export {
        my Int @rc;
        my Str $end_pad = ($s ~~ /\= ** 1..2\s*/).Str;

        for $s.substr(0, * -$end_pad.chars).comb(/\N/) ->
                $left, $left_middle?, $right_middle?, $right? {

            my Int ($left_i, $left_middle_i, $right_middle_i, $right_i) =
                map     { .defined ?? %reverse_mapping{ $_ } !! 0 },
                        $left, $left_middle, $right_middle, $right;

            @rc.push( $left_i +< 2 + $left_middle_i +& 0b00110000 +> 4 );
            if $right_middle.defined {
                @rc.push(
                    $left_middle_i +& 0b00001111 +< 4 +
                    $right_middle_i +& 0b00111100 +> 2
                );
            }
            if $right.defined {
                @rc.push($right_middle_i +& 0b00000011 +< 6 + $right_i);
            }
        }

        return Buf.new(@rc);
    }

    ######################################################################
    our Str sub encode_base64_str(Str $s, Str $e = 'utf-8', :$eol = "\n")
        is export
    {
        encode_base64($s.encode($e), $eol);
    }

    ######################################################################
    our Str sub decode_base64_str(Str $s, Str $d = 'utf-8')
        is export
    {
        decode_base64($s).decode($d);
    }

}
