module Exercise08.Tests exposing (all)

import Exercise08 exposing (Color(..), decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 08"
        [ test "Decodes `\"red\"` into `Red`" <|
            \_ ->
                decodeValue (decoder "red") null
                    |> Expect.equal (Ok Red)
        , test "Decodes `\"green\"` into `Green`" <|
            \_ ->
                decodeValue (decoder "green") null
                    |> Expect.equal (Ok Green)
        , test "Decodes `\"blue\"` into `Blue`" <|
            \_ ->
                decodeValue (decoder "blue") null
                    |> Expect.equal (Ok Blue)
        , fuzz string "Fails when fed other values" <|
            \randomString ->
                decodeValue (decoder randomString) null
                    |> Expect.equal
                        (Err
                            (Json.Decode.Failure
                                ("I don't know a color named " ++ randomString)
                                null
                            )
                        )
        ]
