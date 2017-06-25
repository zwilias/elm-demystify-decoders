module Exercise12.Tests exposing (all)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeValue)
import Fuzz exposing (Fuzzer, string)
import Json.Encode as Encode exposing (Value, null)
import Exercise12 exposing (decoder, Tree(..))


all : Test
all =
    describe "Exercise 12"
        [ fuzz leaf "Decodes random leaf" <|
            \leaf ->
                decodeValue decoder (encodeTree leaf)
                    |> Expect.equal (Ok leaf)
        , fuzz (branch leaf) "Decodes branch with leaves" <|
            \branch ->
                decodeValue decoder (encodeTree branch)
                    |> Expect.equal (Ok branch)
        , fuzz (tree 3) "Decodes random trees" <|
            \tree ->
                decodeValue decoder (encodeTree tree)
                    |> Expect.equal (Ok tree)
        ]


encodeTree : Tree -> Value
encodeTree tree =
    case tree of
        Leaf name val ->
            Encode.object
                [ ( "name", Encode.string name )
                , ( "value", Encode.int val )
                ]

        Branch name children ->
            Encode.object
                [ ( "name", Encode.string name )
                , ( "children", List.map encodeTree children |> Encode.list )
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
        Fuzz.frequency
            [ ( 1, leaf )
            , ( 1, branch (tree <| maxDepth - 1) )
            ]
