module Exercise10.Tests exposing (all)

import Exercise10 exposing (Person, PersonDetails, Role(..), decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 10"
        [ fuzz people "Decodes random people" <|
            \thePeople ->
                let
                    input : Value
                    input =
                        encodePeople thePeople
                in
                decodeValue decoder input
                    |> Expect.equal (Ok thePeople)
        ]


encodePeople : List Person -> Value
encodePeople =
    Encode.list encodePerson


encodePerson : Person -> Value
encodePerson aPerson =
    Encode.object
        [ ( "username", Encode.string aPerson.username )
        , ( "role", encodeRole aPerson.role )
        , ( "details", encodePersonDetails aPerson.details )
        ]


encodePersonDetails : PersonDetails -> Value
encodePersonDetails { registered, aliases } =
    Encode.object
        [ ( "registered", Encode.string registered )
        , ( "aliases", Encode.list Encode.string aliases )
        ]


encodeRole : Role -> Value
encodeRole aRole =
    case aRole of
        Newbie ->
            Encode.string "newbie"

        Regular ->
            Encode.string "regular"

        OldFart ->
            Encode.string "oldfart"


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
    Fuzz.oneOf
        [ Fuzz.constant Newbie
        , Fuzz.constant Regular
        , Fuzz.constant OldFart
        ]
