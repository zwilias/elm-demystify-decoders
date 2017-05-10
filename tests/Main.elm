port module Main exposing (..)

import Exercise01.Tests
import Exercise02.Tests
import Exercise03.Tests
import Exercise04.Tests
import Test exposing (Test, describe)
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


allTests : Test
allTests =
    describe "All exercises"
        [ Exercise01.Tests.all
        , Exercise02.Tests.all
        , Exercise03.Tests.all
        , Exercise04.Tests.all
        ]


main : TestProgram
main =
    run emit Exercise01.Tests.all


port emit : ( String, Value ) -> Cmd msg
