module Exercise06 exposing (decoder, Person)

import Json.Decode exposing (fail, Decoder)


{- Now, onto the "real" stuff: decoding a JS object into an Elm record.

   The record we'll be working with has been given a type alias. This means
   that we can refer to the specific _shape_ of a record (which includes the
   names and types of the fields) by a name.

   However, a type alias for records (and _only_ for records) does just one
   more thing: it creates a magical constructor function. In the case of
   `Person`, this magical constructor function is conveniently named `Person`
   and has the following signature: `String -> Int -> Person`.

   The types in the signature match the fields of the record; in the exact
   order as they were defined.

   You can verify the existence of this constructor function yourself by
   running a REPL (read, eval, print loop) using `elm repl` from the root
   directory of this project, importing this file using `import Exercise06
   exposing (Person)` and getting information about the `Person` function by
   simply typing `Person`:

        > import Exercise06 exposing (Person)
        > Person
        <function> : String -> Int -> Exercise06.Person

   Use the knowledge you've gained so far, and leverage this function to
   construct the required record, feeding the `Person` function the values you
   decode in the order that `Person` expects them.

   Input looks like this, in JS:

        var input = { "name": "Josh", "age": 50 }

   The expected output for the above would be one of the following, which are
   completely equivalent:

        Person "Josh" 50
        == { name = "Josh", age = 50 }

-}


type alias Person =
    { name : String, age : Int }


decoder : Decoder Person
decoder =
    fail "Implement me!"



{- Once you think you're done, run the tests for this exercise from the root of
   the project:

   - If you have installed `elm-test` globally:
        `elm test tests/Exercise06`

   - If you have installed locally using `npm`:
        `npm run elm-test tests/Exercise06`

   - If you have installed locally using `yarn`:
        `yarn elm-test tests/Exercise06`
-}
