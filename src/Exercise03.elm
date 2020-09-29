module Exercise03 exposing (decoder)

import Char
import Json.Decode as JD exposing (Decoder, list, string)



{- So, this one is a tiny bit more challenging, since we don't want _just_ the
   contents of the JSON. No, we want them to be modified.

   input:

       var input = [ "foo", "bar" ];

   output:
       [ "FOO", "BAR" ]

-}


decoder : Decoder (List String)
decoder =
    list (JD.map (String.map Char.toUpper) string)



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm-test tests/Exercise03`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise03`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise03`
-}
