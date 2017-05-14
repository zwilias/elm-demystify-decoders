port module Main exposing (..)

import Exercise01.Tests
import Exercise02.Tests
import Exercise03.Tests
import Exercise04.Tests
import Exercise05.Tests
import Exercise06.Tests
import Exercise07.Tests
import Exercise08.Tests
import Exercise09.Tests
import Exercise10.Tests
import Exercise11.Tests
import Exercise12.Tests
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
        , Exercise05.Tests.all
        , Exercise06.Tests.all
        , Exercise07.Tests.all
        , Exercise08.Tests.all
        , Exercise09.Tests.all
        , Exercise10.Tests.all
        , Exercise11.Tests.all
        , Exercise12.Tests.all
        ]


main : TestProgram
main =
    run emit allTests


port emit : ( String, Value ) -> Cmd msg
