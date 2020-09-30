module Exercise01 exposing (decoder)

import Json.Decode exposing (Decoder, fail)



{- So, you're mystified by JSON decoding in Elm? No worries, let's try and make
   them *click* for you, by going through a set of exercises where you'll be
   gradually creating more and more complex JSON decoders.

   So what _is_ a JSON decoder in Elm, really? Essentially, it is a way to go
   from a raw JavaScript value to an Elm type. So, think of a `Decoder x` as a
   function `JavaScriptValue -> Result String x`.

   Because you can't actually reach into a JavaScript value directly in Elm, a
   set of primitive decoders is already handed to you in the `Json.Decode`
   module.

   So, have a little look at [the documentation][1] - just a quick check of what
   the *primitives* section looks like and their types, and try to adjust the
   following decoder so it can decode a JSON value that looks like `5`.

   [1]: http://package.elm-lang.org/packages/elm/json/latest/Json-Decode
-}


decoder : Decoder Int
decoder =
    fail "I always fail!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm-test tests/Exercise01`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise01`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise01`
-}
