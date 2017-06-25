module Exercise10.Tests exposing (all)

import Test exposing (..)
import Expect
import Json.Decode exposing (decodeValue)
import Fuzz exposing (Fuzzer, string)
import Json.Encode as Encode exposing (Value, null)
import Exercise10 exposing (decoder, Person, PersonDetails, Role(..))


all : Test
all =
    describe "Exercise 10"
        [ fuzz people "Decodes random people" <|
            \people ->
                let
                    input : Value
                    input =
                        encodePeople people
                in
                    decodeValue decoder input
                        |> Expect.equal (Ok people)
        ]


encodePeople : List Person -> Value
encodePeople =
    List.map encodePerson >> Encode.list


encodePerson : Person -> Value
encodePerson { username, role, details } =
    Encode.object
        [ ( "username", Encode.string username )
        , ( "role", encodeRole role )
        , ( "details", encodePersonDetails details )
        ]


encodePersonDetails : PersonDetails -> Value
encodePersonDetails { registered, aliases } =
    Encode.object
        [ ( "registered", Encode.string registered )
        , ( "aliases", List.map Encode.string aliases |> Encode.list )
        ]


encodeRole : Role -> Value
encodeRole =
    toString >> String.toLower >> Encode.string


people : Fuzzer (List Person)
people =
    Fuzz.list person


person : Fuzzer Person
person =
    Fuzz.map3 Person
        Fuzz.string
        role
        personDetails


personDetails : Fuzzer PersonDetails
personDetails =
    Fuzz.map2 PersonDetails
        Fuzz.string
        (Fuzz.list Fuzz.string)


role : Fuzzer Role
role =
    oneOf
        [ Fuzz.constant Newbie
        , Fuzz.constant Regular
        , Fuzz.constant OldFart
        ]


oneOf : List (Fuzzer a) -> Fuzzer a
oneOf =
    List.map ((,) 1)
        >> Fuzz.frequency
