module Exercise11.Tests exposing (all)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeValue)
import Fuzz exposing (Fuzzer, string)
import Json.Encode as Encode exposing (Value, null)
import Exercise11 exposing (decoder)


all : Test
all =
    describe "Exercise 11"
        [ fuzz input "Decodes random input" <|
            \input ->
                decodeValue decoder (encodeInput input)
                    |> Expect.equal (Ok (toList input))
        ]


type Input
    = Single Int
    | Multiple (List Int)


toList : Input -> List Int
toList input =
    case input of
        Single value ->
            [ value ]

        Multiple values ->
            values


input : Fuzzer Input
input =
    oneOf
        [ Fuzz.map Single Fuzz.int
        , Fuzz.map Multiple (Fuzz.list Fuzz.int)
        ]


encodeInput : Input -> Value
encodeInput input =
    case input of
        Single value ->
            Encode.object
                [ ( "number", Encode.int value ) ]

        Multiple values ->
            Encode.object
                [ ( "number", List.map Encode.int values |> Encode.list ) ]


oneOf : List (Fuzzer a) -> Fuzzer a
oneOf =
    List.map ((,) 1)
        >> Fuzz.frequency
