module Exercise05.Tests exposing (all)

import Exercise05 exposing (decoder)
import Expect
import Fuzz exposing (Fuzzer, intRange, string)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Test exposing (..)


all : Test
all =
    describe "Exercise 05"
        [ test "Decode `{ \"term\": \"foo\", \"repeat\": 3 }`" <|
            \() ->
                let
                    input : String
                    input =
                        """
                        { "term": "foo", "repeat": 3 }
                        """
                in
                Json.Decode.decodeString decoder input
                    |> Expect.equal (Ok "foofoofoo")
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
        , fuzz2 string (intRange 0 50) "Decode random term+repeats" <|
            \term repeat ->
                let
                    input : Value
                    input =
                        encodeTerm term repeat

                    output : String
                    output =
                        String.repeat repeat term
                in
                Json.Decode.decodeValue decoder input
                    |> Expect.equal (Ok output)
        ]


encodeTerm : String -> Int -> Value
encodeTerm term repeat =
    Encode.object
        [ ( "term", Encode.string term )
        , ( "repeat", Encode.int repeat )
        ]
