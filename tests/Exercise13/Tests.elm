module Exercise13.Tests exposing (all)

import Exercise13 exposing (JsValue(..), decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 13"
        [ fuzz (jsValue 0) "Decodes primitives" <|
            \jsVal ->
                decodeValue decoder (encoder jsVal)
                    |> Expect.equal (Ok jsVal)
        , fuzz (jsValueDepthRange 1 3) "Decodes random js values" <|
            \jsVal ->
                decodeValue decoder (encoder jsVal)
                    |> Expect.equal (Ok jsVal)
        ]


encoder : JsValue -> Value
encoder jsValue =
    case jsValue of
        IntVal v ->
            Encode.int v

        FloatVal v ->
            Encode.float v

        StringVal v ->
            Encode.string v

        BoolVal v ->
            Encode.bool v

        NullVal ->
            Encode.null

        ListVal values ->
            List.map encoder values |> Encode.list

        ObjectVal kvPairs ->
            List.map (Tuple.mapSecond encoder) kvPairs |> Encode.object


jsValueDepthRange : Int -> Int -> Fuzzer JsValue
jsValueDepthRange min max =
    Fuzz.intRange min max
        |> Fuzz.andThen jsValue


jsValue : Int -> Fuzzer JsValue
jsValue maxDepth =
    if maxDepth == 0 then
        oneOf primitives
    else
        structure maxDepth
            ++ primitives
            |> oneOf


structure : Int -> List (Fuzzer JsValue)
structure maxDepth =
    let
        list : Fuzzer JsValue
        list =
            Fuzz.list (jsValue (maxDepth - 1))
                |> Fuzz.map ListVal

        object : Fuzzer JsValue
        object =
            Fuzz.map2
                (,)
                Fuzz.string
                (jsValue (maxDepth - 1))
                |> Fuzz.list
                |> Fuzz.map ObjectVal
    in
    [ list, object ]


primitives : List (Fuzzer JsValue)
primitives =
    [ Fuzz.map IntVal Fuzz.int
    , Fuzz.map FloatVal Fuzz.float
    , Fuzz.map StringVal Fuzz.string
    , Fuzz.map BoolVal Fuzz.bool
    , Fuzz.constant NullVal
    ]


oneOf : List (Fuzzer a) -> Fuzzer a
oneOf =
    List.map (\f -> ( 1, f ))
        >> Fuzz.frequency
