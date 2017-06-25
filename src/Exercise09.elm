module Exercise09 exposing (decoder, Fruit(..))

import Json.Decode exposing (Decoder, fail)


{- Decoding a union type is something that comes up regularly. And now, young
   padawan, it is time for you to write a complete union-type decoder, too!

   Decoding a union type is essentially a two-step process - first you decode
   the value into a string, and _then_ you feed that string into a decoder
   which can return a decoder that succeeds with the correct value, or fails if
   it cannot be decoded succesfully.

   This second step of this process, you may recognize from the previous
   exercise. For the first step, you'll need to find a function that lets you
   chain decoders by using the result from the previous decoder to build a new
   decoder.

   Input:

        var input = "apple"

   Output:

        Apple

   In case the input cannot be succesfully decoded, an error is expected.
-}


type Fruit
    = Apple
    | Orange
    | Banana


decoder : Decoder Fruit
decoder =
    fail "Nevermind me."


fruitDecoder : String -> Decoder Fruit
fruitDecoder fruitAsString =
    fail "Unknown fruit."



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise09`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise09`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise09`
-}
