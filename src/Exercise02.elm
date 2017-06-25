module Exercise02 exposing (decoder)

import Json.Decode exposing (Decoder, fail)


{- As a second step, let's decode something a tiny bit more complex, that will
   show you how to compose decoders.

   Here are two hints: figure out how to decode the _inner_ type, then figure
   out how to use that to decode what it's enclosed in.

   Expected input will look like this in JS:

       var listToDecode = [ "foo", "bar", "baz" ];

   Expected output will look like this in Elm, on succesfully decoding:

       [ "foo", "bar", "baz" ]
-}


decoder : Decoder (List String)
decoder =
    fail "I still need to be implemented!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise02`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise02`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise02`
-}
