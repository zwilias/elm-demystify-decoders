module Exercise07 exposing (decoder)

import Json.Decode exposing (Decoder, succeed)



{- This one is special.

   In the previous exercises, we've always used information from the javascript
   value to get to our result. Now, we won't!

   The exercise here, is to write a decoder that will always succeed with the
   string "sure."

   You've already seen what a decoder that always fails looks like, so it
   shouldn't be too hard; but it is _very_ important.
-}


decoder : Decoder String
decoder =
    succeed "sure."



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm-test tests/Exercise07`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise07`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise07`
-}
