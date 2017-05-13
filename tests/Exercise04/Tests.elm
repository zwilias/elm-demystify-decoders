module Exercise04.Tests exposing (all)

import Test exposing (..)
import Expect
import Fuzz exposing (int)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Exercise04 exposing (decoder)


all : Test
all =
    describe "Exercise 04"
        [ test "Decode `{ \"age\": 50 }`" <|
            \() ->
                let
                    input : String
                    input =
                        """
                        { "age": 50 }
                        """
                in
                    Json.Decode.decodeString decoder input
                        |> Expect.equal (Ok 50)
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
        , fuzz int "Decode random ages" <|
            \age ->
                let
                    input : Value
                    input =
                        Encode.object
                            [ ( "age", Encode.int age ) ]
                in
                    Json.Decode.decodeValue decoder input
                        |> Expect.equal (Ok age)
        ]
