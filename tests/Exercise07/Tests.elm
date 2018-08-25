module Exercise07.Tests exposing (all)

import Exercise07 exposing (decoder)
import Expect
import Fuzz exposing (Fuzzer)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Test exposing (..)


all : Test
all =
    describe "Exercise 07"
        [ fuzz (jsValue 3) "Decode random JS value" <|
            \val ->
                Json.Decode.decodeValue decoder val
                    |> Expect.equal (Ok "sure.")
        ]


jsValue : Int -> Fuzzer Value
jsValue maxDepth =
    if maxDepth == 0 then
        Fuzz.oneOf primitives

    else
        Fuzz.oneOf (structure maxDepth ++ primitives)


structure : Int -> List (Fuzzer Value)
structure maxDepth =
    let
        list : Fuzzer Value
        list =
            Fuzz.list (jsValue (maxDepth - 1))
                |> Fuzz.map (Encode.list identity)

        object : Fuzzer Value
        object =
            Fuzz.map2
                Tuple.pair
                Fuzz.string
                (jsValue (maxDepth - 1))
                |> Fuzz.list
                |> Fuzz.map Encode.object
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
