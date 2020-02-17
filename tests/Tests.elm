module Tests exposing (..)

import Expect
import Main
import Test exposing (..)


all : Test
all =
    describe "A Test Suite"
        [ test "Addition" <|
            \_ ->
                Main.update Main.NoOp {}
                    |> Expect.equal ( {}, Cmd.none )
        ]
