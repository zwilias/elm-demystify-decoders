module Exercise04 exposing (decoder)

import Json.Decode exposing (Decoder, fail)


{- Something very powerful about decoding in Elm, is that it decouples the
   internal representation of your data from the external representation.

   In this exercise, we'll explore that, _very very_ briefly: we'll make a
   decoder that extracts a single piece of information from an object.

   input:

        var input = { "age": 50 }

   output:

        50

   In order to to this, you'll need to run a primitive decoder on the value of
   that field. How can we do this? Well, the Json.Decode module happens to
   expose a number of decoders that allow "navigating" the JS object, and
   running a decoder on their "target". In this case, you know that the field
   is named `age`, so you'll probably need something that can take a `String`
   and a `Decoder a` and returns a `Decoder a`...
-}


decoder : Decoder Int
decoder =
    fail "tum tum tummmmm"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise04`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise04`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise04`
-}
