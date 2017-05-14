module Exercise13 exposing (decoder, JsValue(..))

import Json.Decode exposing (Decoder, fail)


{- Time for something a _little_ different: let's build a generic JSON decoder!

   This time, your input will be a random javascript value, built entirely out
   of primitives. Your goal is to decode it into a `JsValue` structure, so that
   it accurately represents whatever was passed in.

   A few pointers to prevent you from making silly mistakes:

   - make sure `3` is an `IntVal` and not a `FloatVal`
   - `keyValuePairs` flips the order - adjust for that!
-}


type JsValue
    = StringVal String
    | IntVal Int
    | FloatVal Float
    | BoolVal Bool
    | NullVal
    | ListVal (List JsValue)
    | ObjectVal (List ( String, JsValue ))


decoder : Decoder JsValue
decoder =
    fail "Close, but not quite!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise13/Main.elm`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise13/Main.elm`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise13/Main.elm`
-}
