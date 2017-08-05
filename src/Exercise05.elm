module Exercise05 exposing (decoder)

import Json.Decode exposing (fail, Decoder)


{- Now that you know how to create a decoder which includes calling a function
   to transform a primitive decoder, we're all set to take this principle one
   step further.

   In this exercise, you'll be feeding 2 fields of an object through a single
   function to get the response.

   Concretely; the input will look like this:

        var input = { "term": "foo", "repeat": 3 };

   The expected output is the "term" field, repeated `repeat` times:

        "foofoofoo"


   There is an important lesson to be learned in this exercise - a JS object is
   essentially an unordered list of key-value pairs. You are free to decode
   fields in whichever order you like. If you need field `repeat` before you
   need field `term`; then by all means, decode that field first!
-}


decoder : Decoder String
decoder =
    fail "Implement me!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise05`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise05`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise05`
-}
