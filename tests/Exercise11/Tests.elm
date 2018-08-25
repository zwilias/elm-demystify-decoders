module Exercise11.Tests exposing (all)

import Exercise11 exposing (decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 11"
        [ fuzz input "Decodes random input" <|
            \theInput ->
                decodeValue decoder (encodeInput theInput)
                    |> Expect.equal (Ok (toList theInput))
        ]


type Input
    = Single Int
    | Multiple (List Int)


toList : Input -> List Int
toList theInput =
    case theInput of
        Single value ->
            [ value ]

        Multiple values ->
            values


input : Fuzzer Input
input =
    Fuzz.oneOf
        [ Fuzz.map Single Fuzz.int
        , Fuzz.map Multiple (Fuzz.list Fuzz.int)
        ]


encodeInput : Input -> Value
encodeInput theInput =
    case theInput of
        Single value ->
            Encode.object
                [ ( "number", Encode.int value ) ]

        Multiple values ->
            Encode.object
                [ ( "number", Encode.list Encode.int values ) ]
