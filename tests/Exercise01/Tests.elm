module Exercise01.Tests exposing (all)

import Exercise01 exposing (decoder)
import Expect
import Fuzz exposing (int)
import Json.Decode
import Test exposing (..)


all : Test
all =
    describe "Exercise 01"
        [ test "Decode `1`" <|
            \() ->
                let
                    input : String
                    input =
                        "1"
                in
                Json.Decode.decodeString decoder input
                    |> Expect.equal (Ok 1)
        , test "Does not decode `foo`" <|
            \() ->
                let
                    input : String
                    input =
                        "foo"
                in
                case Json.Decode.decodeString decoder input of
                    Ok _ ->
                        Expect.fail "Did not expect your decoder to succeed decoding \"foo\""

                    Err _ ->
                        Expect.pass
        , fuzz int "Decode random integers" <|
            \randomInteger ->
                let
                    input : String
                    input =
                        String.fromInt randomInteger
                in
                Json.Decode.decodeString decoder input
                    |> Expect.equal (Ok randomInteger)
        ]
