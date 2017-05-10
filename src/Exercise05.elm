module Exercise05 exposing (decoder, Person)

import Json.Decode exposing (fail, Decoder)


{- Now that you know how to create a decoder which includes calling a function
   to transform a primitive decoder, we're all set to take this principle one
   step further.

   In this exercise, you're presented with a function which creates a record
   that based on two pieces of input.

   We can "generalize" the type of `makePerson` to `a -> b -> c` - that is, it takes two parameters, one of type `a`, one of type `b` and returns something of type `c`.

   In the previous exercise, you used a function with signature
   `(a -> b) -> Decoder a -> Decoder b` to transform using a function with
   signature `a -> b`. You can probably guess what the signature for the
   function that we need here will look like!

   Input looks like this, in JS:

        var input = { "name": "Josh", "age": 50 }

   The expected output for the above would be one of the following, which are
   all equivalent:

        makePerson "Josh" 50
        == Person "Josh" 50
        == { name = "Josh", age = 50 }

-}


type alias Person =
    { name : String, age : Int }


makePerson : String -> Int -> Person
makePerson name age =
    { name = name, age = age }


decoder : Decoder Person
decoder =
    fail "Implement me!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise05/Main.elm`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise05/Main.elm`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise05/Main.elm`
-}
