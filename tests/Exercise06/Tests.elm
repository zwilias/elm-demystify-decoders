module Exercise06.Tests exposing (all)

import Exercise06 exposing (Person, decoder)
import Expect
import Fuzz exposing (Fuzzer, int, string)
import Json.Decode
import Json.Encode as Encode exposing (Value)
import Test exposing (..)


all : Test
all =
    describe "Exercise 06"
        [ test "Decode `{ \"name\": \"Josh\", \"age\": 50 }`" <|
            \() ->
                let
                    input : String
                    input =
                        """
                        { "name": "Josh", "age": 50 }
                        """
                in
                Json.Decode.decodeString decoder input
                    |> Expect.equal (Ok <| Person "Josh" 50)
        , test "Does not decode `foo`" <|
            \() ->
                let
                    input : String
                    input =
                        "foo"
                in
                case Json.Decode.decodeString decoder input of
                    Ok _ ->
                        Expect.fail "Did not expect your decoder to succeed decoding \"foo\""

                    Err _ ->
                        Expect.pass
        , fuzz person "Decode random people" <|
            \aPerson ->
                let
                    input : Value
                    input =
                        encodePerson aPerson
                in
                Json.Decode.decodeValue decoder input
                    |> Expect.equal (Ok aPerson)
        ]


person : Fuzzer Person
person =
    Fuzz.map2 Person string int


encodePerson : Person -> Value
encodePerson { name, age } =
    Encode.object
        [ ( "name", Encode.string name )
        , ( "age", Encode.int age )
        ]
