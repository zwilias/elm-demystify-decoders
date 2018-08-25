module Exercise12.Tests exposing (all)

import Exercise12 exposing (Tree(..), decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 12"
        [ fuzz leaf "Decodes random leaf" <|
            \aLeaf ->
                decodeValue decoder (encodeTree aLeaf)
                    |> Expect.equal (Ok aLeaf)
        , fuzz (branch leaf) "Decodes branch with leaves" <|
            \aBranch ->
                decodeValue decoder (encodeTree aBranch)
                    |> Expect.equal (Ok aBranch)
        , fuzz (tree 3) "Decodes random trees" <|
            \aTree ->
                decodeValue decoder (encodeTree aTree)
                    |> Expect.equal (Ok aTree)
        ]


encodeTree : Tree -> Value
encodeTree aTree =
    case aTree of
        Leaf name val ->
            Encode.object
                [ ( "name", Encode.string name )
                , ( "value", Encode.int val )
                ]

        Branch name children ->
            Encode.object
                [ ( "name", Encode.string name )
                , ( "children", Encode.list encodeTree children )
                ]


leaf : Fuzzer Tree
leaf =
    Fuzz.map2 Leaf Fuzz.string Fuzz.int


branch : Fuzzer Tree -> Fuzzer Tree
branch childFuzzer =
    Fuzz.map2 Branch Fuzz.string (Fuzz.list childFuzzer)


tree : Int -> Fuzzer Tree
tree maxDepth =
    if maxDepth == 0 then
        leaf

    else
        Fuzz.oneOf
            [ leaf
            , branch (tree <| maxDepth - 1)
            ]
