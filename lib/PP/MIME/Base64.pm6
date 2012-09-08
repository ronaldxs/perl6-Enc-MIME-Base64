class PP::MIME::Base64 {
    my Str @.mapping = flat 'A' .. 'Z', 'a' .. 'z', '0' .. '9', '+', '/';
    my %.reverse_mapping = (^64).map: { ; @mapping[ $_ ] => $_ };

    method encode(Buf $b --> Str) {
        my Str $rc = '';
        my Str $padding_suffix = '';

        for $b.list -> $byte1, $byte2?, $byte3? {
            $rc ~= @.mapping[ $byte1 +& 0b1111100 +> 2 ];
            if $byte2.defined {
                $rc ~= @.mapping[
                        $byte1 +&  0b00000011 +< 4 +
                        $byte2 +&  0b11110000 +> 4
                ];
                if $byte3.defined {
                    $rc ~= @.mapping[
                            $byte2 +&  0b00001111 +< 2 +
                            $byte3 +&  0b11000000 +> 6
                        ] ~
                        @.mapping[ $byte3 +& 0b00111111 ];
                }
                else {
                    $rc ~= @.mapping[ $byte2 +& 0b00001111 +< 2 ];
                    $padding_suffix ~= '=';
                }
            }
            else {
                $rc ~= @.mapping[ $byte1 +&  0b00000011 +< 4 ];
                $padding_suffix ~= '==';
            }                
        } 

        return $rc ~ $padding_suffix;
    }

    method decode(Str $s --> Buf) {
        my $zero_pad_count = 0;

        for 1, 2 -> $i {
            if $s.substr(* -$i, 1) eq '=' { $zero_pad_count++ }
        }

        my $result_len = 3 * ($s.chars - $zero_pad_count) / 4 - $zero_pad_count;

        # should be able to pre-allocate this buffer some day
        my Buf $rc .= new();

        for $s.substr(0, * -$zero_pad_count).comb ->
                $left, $left_middle?, $right_middle?, $right? {

            unless $right.defined { die "malformed utf-8 string" }

            my Int ($left_i, $left_middle_i, $right_middle_i, $right_i) =
                map     { %.reverse_mapping[ $_ ] },
                        $left, $left_middle, $right_middle, $right_middle_i;
            $rc[ $rc.bytes ] = $left_i +< 2 +
                $left_middle_i +& 0b00110000 +> 6;
            if $rc.bytes < $result_len {
                $rc[ $rc.bytes ] = $left_middle_i +& 0b00001111 +< 4 +
                    $right_middle_i +& 0b00111100 +> 2;
            }
            if $rc.bytes < $result_len {
                $rc[ $rc.bytes ] = $right_middle_i +& 0b00000011 +< 6 +
                    $right_i;
            }
        }

        return $rc;
    }

}
