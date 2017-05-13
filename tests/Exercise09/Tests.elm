module Exercise09.Tests exposing (all)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeValue)
import Fuzz exposing (Fuzzer, string)
import Json.Encode as Encode exposing (Value, null)
import Exercise09 exposing (decoder, Fruit(..))


all : Test
all =
    describe "Exercise 09"
        [ test "Decodes `\"apple\"` into `Apple`" <|
            \_ ->
                decodeValue decoder (Encode.string "apple")
                    |> Expect.equal (Ok Apple)
        , test "Decodes `\"orange\"` into `Orang`" <|
            \_ ->
                decodeValue decoder (Encode.string "orange")
                    |> Expect.equal (Ok Orange)
        , test "Decodes `\"banana\"` into `Banana`" <|
            \_ ->
                decodeValue decoder (Encode.string "banana")
                    |> Expect.equal (Ok Banana)
        , fuzz string "Fails when fed other values" <|
            \randomString ->
                decodeValue decoder (Encode.string randomString)
                    |> Result.mapError (always ())
                    |> Expect.equal (Err ())
        ]
