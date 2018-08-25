module Exercise03.Tests exposing (all)

import Exercise03 exposing (decoder)
import Expect
import Fuzz exposing (list, string)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Test exposing (..)


all : Test
all =
    describe "Exercise 03"
        [ test "Decode `[ \"foo\", \"bar\" ]`" <|
            \() ->
                let
                    input : String
                    input =
                        """
                        [ "foo", "bar" ]
                        """
                in
                Json.Decode.decodeString decoder input
                    |> Expect.equal (Ok [ "FOO", "BAR" ])
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
                        Encode.list Encode.string strings
                in
                Json.Decode.decodeValue decoder input
                    |> Expect.equal (Ok (List.map String.toUpper strings))
        ]
