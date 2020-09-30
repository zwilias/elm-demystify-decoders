module Exercise08 exposing (Color(..), decoder)

import Json.Decode exposing (Decoder, fail, succeed)



{- You've already seen that a decoder can completely ignore whatever is going on
   in the javascript value. This opens possibilities, for example we can make a
   decoder that simply takes a `String` and decodes this into a union type, or
   fails with a nice error message if the input is not valid.

   Note that this function will look quite similar to a function that would
   decode into a`Result String Color` - the major difference being that
   `Decoder` isn't a union type, but holds internal state. You also need
   functions to build a decoder, rather than calling constructors.

   When `decoder` is called with `"green"`, it is expected to return a decoder
   that always succeeds with `Green`. The same applies for `"blue"` and `"red"`.

   When `decoder` is called with a different string, like `"foo"`, it is expected
   to return a decoder that always fails with `"I don't know a color named foo"`
-}


type Color
    = Green
    | Blue
    | Red


decoder : String -> Decoder Color
decoder colorString =
    case colorString of
        "green" ->
            succeed Green

        "blue" ->
            succeed Blue

        "red" ->
            succeed Red

        _ ->
            fail <| "I don't know a color named " ++ colorString



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm-test tests/Exercise08`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise08`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise08`
-}
