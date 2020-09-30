module Exercise10 exposing (Person, PersonDetails, Role(..), decoder)

import Exercise06 exposing (Person)
import Json.Decode exposing (Decoder, andThen, fail, field, list, map2, map3, string, succeed)



{- Let's try and do a complicated decoder, this time. No worries, nothing new
   here: applying the techniques you've used in the previous decoders should
   help you through this one.

   A couple of pointers:
    - try working "inside out". Write decoders for the details and role first
    - combine those decoders + the username and map them into the Person constructor
    - finally, wrap it all together to build it into a list of people


   Example input:

        [ { "username": "Phoebe"
          , "role": "regular"
          , "details":
            { "registered": "yesterday"
            , "aliases": [ "Phoebs" ]
            }
          }
        ]
-}


type alias Person =
    { username : String
    , role : Role
    , details : PersonDetails
    }


type alias PersonDetails =
    { registered : String
    , aliases : List String
    }


type Role
    = Newbie
    | Regular
    | OldFart


personDetailsDecoder : Decoder PersonDetails
personDetailsDecoder =
    map2 PersonDetails (field "registered" string) (field "aliases" (list string))


personDecoder : Decoder Person
personDecoder =
    map3 Person (field "username" string) (field "role" roleDecoder) (field "details" personDetailsDecoder)


roleDecoder : Decoder Role
roleDecoder =
    string |> andThen stringToRole


stringToRole : String -> Decoder Role
stringToRole r =
    case r of
        "newbie" ->
            succeed Newbie

        "regular" ->
            succeed Regular

        "oldfart" ->
            succeed OldFart

        _ ->
            fail "Dont know this user"


decoder : Decoder (List Person)
decoder =
    list personDecoder



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm-test tests/Exercise10`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise10`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise10`
-}
