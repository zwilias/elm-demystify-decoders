module Exercise02.Tests exposing (all)

import Test exposing (..)
import Expect
import Fuzz exposing (list, string)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Exercise02 exposing (decoder)


all : Test
all =
    describe "Exercise 02"
        [ test "Decode `[ \"foo\", \"bar\", \"baz\" ]`" <|
            \() ->
                let
                    input : String
                    input =
                        """
                        [ "foo", "bar", "baz" ]
                        """
                in
                    Json.Decode.decodeString decoder input
                        |> Expect.equal (Ok [ "foo", "bar", "baz" ])
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
        , fuzz (list string) "Decode random lists of strings" <|
            \strings ->
                let
                    input : Value
                    input =
                        encodeStringList strings
                in
                    Json.Decode.decodeValue decoder input
                        |> Expect.equal (Ok strings)
        ]


encodeStringList : List String -> Value
encodeStringList =
    List.map Encode.string >> Encode.list
