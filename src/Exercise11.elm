module Exercise11 exposing (decoder)

import Json.Decode exposing (Decoder, fail)


{- Every once in a while, you'll have to deal with oddly structured data. Let's
   look at one very important tool when dealing with polymorphic data. In this
   exercise, you will decode a javascript value that will have a key `number`
   that may either be a single value, or a list of values.

   The task is to always return a list of values. That is to say, if the input
   is a single number, the output should be "normalized" into a list with a
   single item in it.

   example input:

        var input1 = { "number": 5 }
        var input2 = { "number": [ 1, 2, 3 ] }

   expected output:

        output1 = [ 5 ]
        output2 = [ 1, 2, 3 ]

   As always, the docs can be helpful in figuring out which function to use. As
   a hint, it involves working with a list of possible decoders.
-}


decoder : Decoder (List Int)
decoder =
    fail "Implement me!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise11`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise11`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise11`
-}
