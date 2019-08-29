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
        [ fuzz primitive "Decodes JS primitives" <|
            \val ->
                Json.Decode.decodeValue decoder val
                    |> Expect.equal (Ok "sure.")
        , fuzz structure "Decodes objects and lists" <|
            \val ->
                Json.Decode.decodeValue decoder val
                    |> Expect.equal (Ok "sure.")
        ]


structure : Fuzzer Value
structure =
    let
        list : Fuzzer Value
        list =
            Fuzz.list primitive
                |> Fuzz.map (Encode.list identity)

        object : Fuzzer Value
        object =
            Fuzz.map2
                Tuple.pair
                Fuzz.string
                primitive
                |> Fuzz.list
                |> Fuzz.map Encode.object
    in
    Fuzz.oneOf [ list, object ]


primitive : Fuzzer Value
primitive =
    Fuzz.oneOf
        [ Fuzz.map Encode.int Fuzz.int
        , Fuzz.map Encode.float Fuzz.float
        , Fuzz.map Encode.string Fuzz.string
        , Fuzz.map Encode.bool Fuzz.bool
        , Fuzz.constant Encode.null
        ]
