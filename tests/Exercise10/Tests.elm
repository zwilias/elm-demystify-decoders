module Exercise10.Tests exposing (all)

import Exercise10 exposing (Person, PersonDetails, Role(..), decoder)
import Expect
import Fuzz exposing (Fuzzer, string)
import Json.Decode exposing (decodeString, decodeValue)
import Json.Encode as Encode exposing (Value, null)
import Test exposing (..)


all : Test
all =
    describe "Exercise 10"
        [ test "Decodes the example" <|
            \_ ->
                let
                    input : String
                    input =
                        """
[ { "username": "Phoebe"
  , "role": "regular"
  , "details":
    { "registered": "yesterday"
    , "aliases": ["Phoebs"]
    }
  }
]"""
                in
                decodeString decoder input
                    |> Expect.equal
                        (Ok
                            [ { username = "Phoebe"
                              , role = Regular
                              , details =
                                    { registered = "yesterday"
                                    , aliases = [ "Phoebs" ]
                                    }
                              }
                            ]
                        )
        , test "Does not allow invalid roles" <|
            \_ ->
                let
                    input : String
                    input =
                        """
[ { "username": "Phoebe"
  , "role": "rEgUlAr_"
  , "details":
    { "registered": "yesterday"
    , "aliases": []
    }
  }
]"""
                in
                decodeString decoder input
                    |> Expect.err
        , fuzz people "Decodes random people" <|
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
    Fuzz.map4
        (\username role_ registered aliases ->
            { username = username
            , role = role_
            , details =
                { registered = registered
                , aliases = aliases
                }
            }
        )
        Fuzz.string
        role
        Fuzz.string
        (Fuzz.list Fuzz.string)


role : Fuzzer Role
role =
    Fuzz.oneOf
        [ Fuzz.constant Newbie
        , Fuzz.constant Regular
        , Fuzz.constant OldFart
        ]
