module Exercise07.Tests exposing (all)

import Test exposing (..)
import Expect
import Json.Decode
import Fuzz exposing (Fuzzer)
import Json.Encode as Encode exposing (Value)
import Exercise07 exposing (decoder)


all : Test
all =
    describe "Exercise 07"
        [ fuzz (jsValueDepthRange 0 3) "Decode random JS value" <|
            \jsValue ->
                Json.Decode.decodeValue decoder jsValue
                    |> Expect.equal (Ok "sure.")
        ]


jsValueDepthRange : Int -> Int -> Fuzzer Value
jsValueDepthRange min max =
    Fuzz.intRange min max
        |> Fuzz.andThen jsValue


jsValue : Int -> Fuzzer Value
jsValue maxDepth =
    if maxDepth == 0 then
        oneOf primitives
    else
        (structure maxDepth)
            ++ primitives
            |> oneOf


structure : Int -> List (Fuzzer Value)
structure maxDepth =
    let
        list : Fuzzer Value
        list =
            Fuzz.list (jsValue (maxDepth - 1))
                |> Fuzz.map (Encode.list)

        object : Fuzzer Value
        object =
            Fuzz.map2
                ((,))
                Fuzz.string
                (jsValue (maxDepth - 1))
                |> Fuzz.list
                |> Fuzz.map (Encode.object)
    in
        [ list, object ]


primitives : List (Fuzzer Value)
primitives =
    [ Fuzz.map Encode.int Fuzz.int
    , Fuzz.map Encode.float Fuzz.float
    , Fuzz.map Encode.string Fuzz.string
    , Fuzz.map Encode.bool Fuzz.bool
    , Fuzz.constant Encode.null
    ]


oneOf : List (Fuzzer a) -> Fuzzer a
oneOf =
    List.map (\f -> ( 1, f ))
        >> Fuzz.frequency
